import Vapor

/// An interface for the PayPal REST API.
public final class PayPalClient: ServiceType {
    
    /// The client object used to send requests to the PayPal API.
    internal let client: Client
    
    /// The data used to authenticate with the PayPal API.
    public internal(set) var auth: AuthInfo
    
    /// The PayPal environment to send the requests to.
    public internal(set) var environment: Environment
    
    /// Creates a new PayPal client with a given container.
    ///
    /// - Note: Instead of calling this initializer, you should register the
    ///   provider and call `container.make(PayPalClient.self)`.
    public init(client: Client, env: Environment) {
        self.environment = env
        self.client = client
        self.auth = AuthInfo()
    }
    
    /// Creates a new instance of the service for the supplied `Container`.
    ///
    /// See `ServiceFactory` for more information.
    public static func makeService(for worker: Container) throws -> Self {
        return try self.init(client: worker.make(), env: worker.make(Configuration.self).environment)
    }
    
    public func request<Body>(
        _ method: HTTPMethod,
        _ path: String,
        parameters: QueryParamaters = QueryParamaters(),
        headers: HTTPHeaders = [:],
        auth: Bool = true,
        body: Body?
    )throws -> Request where Body: Encodable {
        let querystring = parameters.encode()
        let path = self.environment.domain + "/" + path + (querystring == "" ? "" : "?" + querystring)
        
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
    ) -> Future<Result> where Body: Content, Result: Content {
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
    ) -> Future<Result> where Result: Content {
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
    ) -> Future<Result> where Body: Content, Result: Content {
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
    ) -> Future<Result> where Result: Content {
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
    ) -> Future<Result> where Body: Content, Result: Content {
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
    ) -> Future<Result> where Result: Content {
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
    ) -> Future<Result> where Body: Content, Result: Content {
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
    ) -> Future<Result> where Result: Content {
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
    ) -> Future<Result> where Body: Content, Result: Content {
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
    ) -> Future<Result> where Result: Content {
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
    ) -> Future<Result> where Body: Content, Result: Content {
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
    ) -> Future<Result> where Result: Content {
        return self.send(.DELETE, path, parameters: parameters, headers: headers, as: Result.self)
    }
}
