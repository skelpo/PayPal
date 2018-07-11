import Vapor

/// An interface for the PayPal REST API.
public final class PayPalClient: ServiceType {
    
    /// The current container that the service instance is connected to.
    public let container: Container
    
    /// Creates a new PayPal client with a given container.
    ///
    /// - Note: Instead of calling this initializer, you should register the
    ///   provider and call `container.make(PayPalClient.self)`.
    public init(container: Container) {
        self.container = container
    }
    
    /// Creates a new instance of the service for the supplied `Container`.
    ///
    /// See `ServiceFactory` for more information.
    public static func makeService(for worker: Container) throws -> Self {
        return self.init(container: worker)
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
        headers: HTTPHeaders = [:],
        body: Body?,
        as response: Result.Type = Result.self
    ) -> Future<Result> where Body: Content, Result: Content {
        return self.container.paypal(method, path, headers: headers, body: body, as: Result.self)
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
        headers: HTTPHeaders = [:],
        as response: Result.Type = Result.self
    ) -> Future<Result> where Result: Content {
        return self.container.paypal(method, path, headers: headers, as: Result.self)
    }
}
