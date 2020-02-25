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
    
    /// Fetches the registered `PayPalClient` instance from the container and makes it
    /// availible in a closure, so any errors that are thrown can be caught and returned in the resulting future.
    ///
    /// - Parameter closure: The closure you have access to the `PayPalClient` in.
    ///
    /// - Returns: The future returned from the closure passed in.
    public func client<T>(_ closure: (PayPalClient)throws -> (Future<T>)) -> Future<T> {
        do {
            let client = try self.container.make(PayPalClient.self)
            return try closure(client)
        } catch let error {
            return self.container.future(error: error)
        }
    }
}

// TODO: - Renamed protocol to PayPalController.

/// A controller that handles a versioned resource of the PayPal API.
public protocol VersionedController {
    
    /// The `PayPalClient` instance used to send requests to the PayPal API.
    var client: PayPalClient { get }
    
    /// The path components for the API resource that the controller interacts with.
    var resource: [String] { get }
    
    /// Creates a new instance of `Self` with the `PayPalClient` instance that will be used by it.
    ///
    /// - Parameter client: The `PayPalClient` instance to send requests with.
    init(client: PayPalClient)
}

extension VersionedController {
    
    /// The resource elements joined togeather as a URL path.
    public var path: String {
        return self.resource.joined(separator: "/") + "/"
    }
}
