/// The PayPal environment to use when making requests to the API.
public enum Environment: String, Codable, CaseIterable {
    
    /// For testing environments; to make sure you app is working as expected.
    case sandbox
    
    /// For production environments.
    case production
    
    /// The root of the URI used to access the PayPal API
    /// based on the current environment.
    var domain: String {
        switch self {
        case .sandbox: return "https://api.sandbox.paypal.com"
        case .production: return "https://api.paypal.com"
        }
    }
}
