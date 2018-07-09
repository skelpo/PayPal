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
}
