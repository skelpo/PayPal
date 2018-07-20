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
    
    /// The controller's path used on the PayPal API.
    ///
    /// The default value is `v{Configuration.version}/{resource}/`.
    func path()throws -> String
}

extension PayPalController {
    
    /// See [`ServiceType.makeService(for:)`](https://api.vapor.codes/service/latest/Service/Protocols/ServiceType.html#/s:7Service0A4TypeP04makeA0xAA9Container_p3for_tKFZ).
    public static func makeService(for worker: Container) throws -> Self {
        return Self.init(container: worker)
    }
    
    /// The controller's path used on the PayPal API.
    ///
    /// The default value is `v{Configuration.version}/{resource}/`.
    public func path()throws -> String {
        let config = try self.container.make(Configuration.self)
        return "v" + String(describing: config.version) + "/" + resource + "/"
    }
}
