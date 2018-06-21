import Vapor

public final class Provider: Vapor.Provider {
    public func register(_ services: inout Services) throws {
        
    }
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return container.future()
    }
}

/// Global configuration data required to use the PayPal API.
public final class Configuration: Service {
    
    /// Your PayPal client ID.
    public let id: String
    
    /// Your PayPal client secret value.
    public let secret: String
    
    /// The PayPal environment to send requests to.
    /// This value is based on the app current environment.
    ///
    /// If the app was boot in the a release environment, it will
    /// be `.production`, otherwise it will be `.sandbox`.
    public let environment: PayPal.Environment
    
    init(id: String, secret: String, environment: Environment) {
        self.id = id
        self.secret = secret
        self.environment = environment
    }
}
