import Vapor

/// An interface to a PayPal REST API resource.
public protocol PayPalController: ServiceType {
    
    /// The worker that controller is connected to. This is typically a `Request` object.
    var container: Container { get }
    
    /// The API resource that the controller connects to.
    var resource: String { get }
    
    /// Creates an instance of the controller on a given container.
    ///
    /// Instead of directly initializing the controller, you should register
    /// the provider and get the controller using `container.make(Controller.self)`.
    ///
    /// - Parameter container: The container that the controller belongs to.
    init(container: Container)
}
