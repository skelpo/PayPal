import Vapor
import PayPal

public var secret: String! = nil
public var id: String! = nil

extension Application {
    public static func testable(
        services: Services = .default(),
        environment: Vapor.Environment = .testing,
        environmentArguments: [String]? = nil
        )throws -> Application {
        let config = Config.default()
        var env = environment
        
        if let arguments = environmentArguments {
            env.arguments = arguments
        } else {
            env.arguments = ["vapor", "serve"]
        }
        
        return try Application(config: config, environment: env, services: services)
    }
}

public func setPaypalVars() {
    if let clientID = Environment.get("PAYPAL_CLIENT_ID") {
        id = clientID
    } else {
        id = "fake_paypal_id"
        setenv("PAYPAL_CLIENT_ID", id, 1)
    }
    
    if let clientID = Environment.get("PAYPAL_CLIENT_SECRET") {
        secret = clientID
    } else {
        secret = "fake_paypal_secret"
        setenv("PAYPAL_CLIENT_SECRET", secret, 1)
    }
}

extension PayPalProvider {
    public convenience init() {
        self.init(id: id, secret: secret)
    }
}
