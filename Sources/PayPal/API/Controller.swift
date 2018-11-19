import Vapor

/// An interface to a PayPal REST API resource.
public protocol PayPalController: ServiceType {
    
    /// The worker that controller is connected to. This is typically a `Request` object.
    var container: Container { get }
    
    /// The API resource that the controller connects to.
    var resource: String { get }
    
    /// The version of the PayPal API to use when making request's to the API.
    ///
    /// Defaults to `.v1`.
    var version: Version { get }
    
    /// Creates an instance of the controller on a given container.
    ///
    /// Instead of directly initializing the controller, you should register
    /// the provider and get the controller using `container.make(Controller.self)`.
    ///
    /// - Parameter container: The container that the controller belongs to.
    init(container: Container)
}

extension PayPalController {
    
    /// See [`ServiceType.makeService(for:)`](https://api.vapor.codes/service/latest/Service/Protocols/ServiceType.html#/s:7Service0A4TypeP04makeA0xAA9Container_p3for_tKFZ).
    public static func makeService(for worker: Container) throws -> Self {
        return Self.init(container: worker)
    }
    
    /// The controller's path used on the PayPal API.
    public var path: String {
        return "v" + self.version.rawValue + "/" + resource + "/"
    }
}
