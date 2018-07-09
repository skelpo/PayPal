import Vapor

var secret: String! = nil
var id: String! = nil

extension Application {
    static func testable(
        services: Services = .default(),
        environment: Environment = .testing,
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

func setPaypalVars() {
    if let clientID = Environment.get("PAYPAL_CLIENT_ID") {
        id = clientID
    } else {
        id = "fake_paypal_id"
        setenv("PAYPAL_CLIENT_ID", id, 1)
    }
    
    if let clientID = Environment.get("PAYPAL_CLIENT_SECRET") {
        id = clientID
    } else {
        id = "fake_paypal_secret"
        setenv("PAYPAL_CLIENT_SECRET", id, 1)
    }
}
