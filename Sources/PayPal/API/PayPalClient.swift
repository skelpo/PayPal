import Vapor

/// An interface for the PayPal REST API.
public final class PayPalClient: ServiceType {
    
    /// The client object used to send requests to the PayPal API.
    internal let client: Client
    
    /// The root URL (domain and API version) of all API calls.
    internal let root: String
    
    /// The PayPal API version that the client will be used on.
    public let version: Version
    
    /// The PayPal environment to send the requests to.
    public let environment: Environment
    
    /// The data used to authenticate with the PayPal API.
    public internal(set) var auth: AuthInfo
    
    /// Creates a new PayPal client with a given container.
    ///
    /// - Note: Instead of calling this initializer, you should register the
    ///   provider and call `container.make(PayPalClient.self)`.
    public init(client: Client, version: Version, env: Environment) {
        self.client = client
        self.version = version
        self.environment = env
        self.auth = AuthInfo()
        
        self.root = self.environment.domain + "/v" + self.version.rawValue + "/"
    }
    
    /// Creates a new instance of the service for the supplied `Container`.
    ///
    /// See `ServiceFactory` for more information.
    public static func makeService(for worker: Container) throws -> Self {
        let config = try worker.make(Configuration.self)
        return try self.init(client: worker.make(), version: config.version, env: config.environment)
    }
    
    /// A helper to create requests that will be sent to the PayPal REST API.
    ///
    /// Besides creating a `Request` instance with the data passed in, this method will also add
    /// the authentication header if authorization in desired.
    ///
    /// - Parameters:
    ///   - method: The HTTP of the request.
    ///   - path: The resource path for the request. The domain for the client's environment is appended to
    ///     the front of this string the create the full URL.
    ///   - headers: Any headers to send in the request, besides the any that are automatically added.
    ///   - auth: A boolean flag indicating whether the request should have an authorization header or not.
    ///   - body: The body of the request.
    public func request<Body>(
        _ method: HTTPMethod,
        _ path: String,
        parameters: QueryParamaters = QueryParamaters(),
        headers: HTTPHeaders = [:],
        auth: Bool = true,
        body: Body?
    )throws -> Request where Body: Encodable {
        let querystring = parameters.encode()
        let path = self.root + path + (querystring == "" ? "" : "?" + querystring)
        
        let http = HTTPRequest(method: method, url: path, headers: headers)
        let request = Request(http: http, using: self.client.container)
        
        if auth {
            guard let type = self.auth.type, let token = self.auth.token else {
                throw Abort(
                    .internalServerError,
                    reason: "Attempted to make a PayPal request that requires auth before authenticating."
                )
            }
            
            request.http.headers.replaceOrAdd(name: .authorization, value: type + " " + token)
        }
        
        if let body = body {
            let contentType: MediaType = auth ? .json : .urlEncodedForm
            try request.content.encode(body, as: contentType)
        }
        
        return request
    }
    
    /// Sends a request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - method: The HTTP method for the endpoint.
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - body: The body of the request. This will encoded to JSON.
    ///     Required for most GET, POST, PUT, and PATCH calls.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func send<Body, Result>(
        _ method: HTTPMethod,
        _ path: String,
        parameters: QueryParamaters = QueryParamaters(),
        headers: HTTPHeaders = [:],
        body: Body?,
        as response: Result.Type = Result.self
    ) -> Future<Result> where Body: Encodable, Result: Decodable {
        let authentication: EventLoopFuture<Void>
        if self.auth.tokenExpired {
            authentication = self.authenticate()
        } else {
            authentication = self.client.container.future()
        }
        
        return authentication.flatMap { () -> EventLoopFuture<Response> in
            let request = try self.request(method, path, parameters: parameters, headers: headers, auth: true, body: body)
            return self.client.send(request)
        }.flatMap { response -> EventLoopFuture<Result> in
            if !(200...299).contains(response.http.status.code) {
                guard response.http.headers.firstValue(name: .contentType) == "application/json" else {
                    let body = response.http.body.data ?? Data()
                    let error = String(data: body, encoding: .utf8)
                    throw Abort(response.http.status, reason: error)
                }
                
                return try response.content.decode(PayPalAPIError.self).catchFlatMap { _ in
                    return try response.content.decode(PayPalAPIIdentityError.self).map { error in throw error }
                }.map { error in
                    throw error
                }
            }
            
            if Result.self is HTTPStatus.Type {
                return self.client.container.future(response.http.status as! Result)
            }
            return try response.content.decode(Result.self)
        }
    }
    
    /// Sends a request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - method: The HTTP method for the endpoint.
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func send<Result>(
        _ method: HTTPMethod,
        _ path: String,
        parameters: QueryParamaters = QueryParamaters(),
        headers: HTTPHeaders = [:],
        as response: Result.Type = Result.self
    ) -> Future<Result> where Result: Decodable {
        return self.send(method, path, parameters: parameters, headers: headers, body: nil as [String: String]?, as: Result.self)
    }
    
    /// Sends a `GET` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - body: The body of the request. This will encoded to JSON.
    ///     Required for most GET, POST, PUT, and PATCH calls.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func get<Body, Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], body: Body?, as response: Result.Type = Result.self
    ) -> Future<Result> where Body: Encodable, Result: Decodable {
        return self.send(.GET, path, parameters: parameters, headers: headers, body: body, as: Result.self)
    }
    
    /// Sends a `GET` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func get<Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], as response: Result.Type = Result.self
    ) -> Future<Result> where Result: Decodable {
        return self.send(.GET, path, parameters: parameters, headers: headers, as: Result.self)
    }
    
    /// Sends a `POST` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - body: The body of the request. This will encoded to JSON.
    ///     Required for most GET, POST, PUT, and PATCH calls.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func post<Body, Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], body: Body?, as response: Result.Type = Result.self
    ) -> Future<Result> where Body: Encodable, Result: Decodable {
        return self.send(.POST, path, parameters: parameters, headers: headers, body: body, as: Result.self)
    }
    
    /// Sends a `POST` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func post<Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], as response: Result.Type = Result.self
    ) -> Future<Result> where Result: Decodable {
        return self.send(.POST, path, parameters: parameters, headers: headers, as: Result.self)
    }
    
    /// Sends a `PUT` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - body: The body of the request. This will encoded to JSON.
    ///     Required for most GET, POST, PUT, and PATCH calls.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func put<Body, Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], body: Body?, as response: Result.Type = Result.self
    ) -> Future<Result> where Body: Encodable, Result: Decodable {
        return self.send(.PUT, path, parameters: parameters, headers: headers, body: body, as: Result.self)
    }
    
    /// Sends a `PUT` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func put<Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], as response: Result.Type = Result.self
    ) -> Future<Result> where Result: Decodable {
        return self.send(.PUT, path, parameters: parameters, headers: headers, as: Result.self)
    }
    
    /// Sends a `PATCH` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - body: The body of the request. This will encoded to JSON.
    ///     Required for most GET, POST, PUT, and PATCH calls.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func patch<Body, Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], body: Body?, as response: Result.Type = Result.self
    ) -> Future<Result> where Body: Encodable, Result: Decodable {
        return self.send(.PATCH, path, parameters: parameters, headers: headers, body: body, as: Result.self)
    }
    
    /// Sends a `PATCH` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func patch<Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], as response: Result.Type = Result.self
    ) -> Future<Result> where Result: Decodable {
        return self.send(.PATCH, path, parameters: parameters, headers: headers, as: Result.self)
    }
    
    /// Sends a `DELETE` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - body: The body of the request. This will encoded to JSON.
    ///     Required for most GET, POST, PUT, and PATCH calls.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func delete<Body, Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], body: Body?, as response: Result.Type = Result.self
    ) -> Future<Result> where Body: Encodable, Result: Decodable {
        return self.send(.DELETE, path, parameters: parameters, headers: headers, body: body, as: Result.self)
    }
    
    /// Sends a `DELETE` request to the PayPal REST API, using the configured environment.
    ///
    /// - Parameters:
    ///   - path: The endpoint's URL path, i.e. `/v1/activities/activities`
    ///   - headers: Additional headers to send with the request.
    ///     The `Authorization` header is added automatically.
    ///   - response: The type that the response JSON should be decoded to.
    /// - Returns: The endpoint's response, encoded to the `Result` type.
    public func delete<Result>(
        _ path: String, parameters: QueryParamaters = QueryParamaters(), headers: HTTPHeaders = [:], as response: Result.Type = Result.self
    ) -> Future<Result> where Result: Decodable {
        return self.send(.DELETE, path, parameters: parameters, headers: headers, as: Result.self)
    }
}
