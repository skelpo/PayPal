import Vapor

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
