import Vapor

typealias Env = Vapor.Environment

/// Configures services required for PayPal API interaction
///
/// - `Configuration`
/// - `AuthInfo`
/// - `PayPalClient`
///
/// This provider needs 2 environment variables:
///
/// - `PAYPAL_CLIENT_ID`: Your PayPal dev client ID.
/// - `PAYPAL_CLIENT_SECRET`: Your PayPal client secret.
public final class Provider: Vapor.Provider {
    
    let version: Float
    
    /// Creates a new `PayPal.Provider` instance to register with an
    /// application's `Services`.
    ///
    ///      try services.register(PayPal.Provider())
    ///
    /// - Parameter version: The version of the PayPal API to use when making requests.
    public init(version: Float = 1)throws {
        let validVersions: [Float] = [1]
        
        guard validVersions.contains(version) else {
            throw Abort(.internalServerError, reason: "API version \(version) is not supported.")
        }
        
        self.version = version
    }
    
    /// Registers all services to the app's services.
    public func register(_ services: inout Services) throws {
        guard let id = Env.get("PAYPAL_CLIENT_ID") else {
            throw PayPalError(identifier: "envVarNotFound", reason: "Environment variable 'PAYPAL_CLIENT_ID' was not found")
        }
        guard let secret = Env.get("PAYPAL_CLIENT_SECRET") else {
            throw PayPalError(identifier: "envVarNotFound", reason: "Environment variable 'PAYPAL_SECRET_ID' was not found")
        }
        
        services.register(Configuration(id: id, secret: secret, version: self.version))
        services.register(AuthInfo())
        services.register(PayPalClient.self)
    }
    
    /// Gets the current app environment and registers the proper PayPal environment to the configuration.
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        let config = try container.make(Configuration.self)
        config.environment = container.environment.isRelease ? .production : .sandbox
        
        return container.future()
    }
}

/// Global configuration data required to use the PayPal API.
public final class Configuration: Service {
    
    /// Your PayPal client ID.
    public let id: String
    
    /// Your PayPal client secret value.
    public let secret: String
    
    /// The version of the PayPal API being used.
    public let version: Float
    
    /// The PayPal environment to send requests to.
    /// This value is based on the app current environment.
    ///
    /// If the app was boot in the a release environment, it will
    /// be `.production`, otherwise it will be `.sandbox`.
    public internal(set) var environment: PayPal.Environment!
    
    init(id: String, secret: String, version: Float) {
        self.id = id
        self.secret = secret
        self.environment = nil
        self.version = version
    }
}