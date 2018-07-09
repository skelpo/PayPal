import Vapor

/// Information about the current auth state with the PayPal API.
public final class AuthInfo: Service {
    
    /// The current access token from authenticating with the API.
    public internal(set) var token: String?
    
    /// When the current token will expire.
    public internal(set) var expiresAt: Date?
    
    /// The availible endpoints that can be accessed using the current token.
    public internal(set) var scopes: [String]
    
    /// The ID of the app in your PayPal dev dashboard.
    public internal(set) var appID: String?
    
    /// The auth method that is used with the current token.
    public internal(set) var type: String?
    
    init() {
        self.token = nil
        self.expiresAt = nil
        self.scopes = []
        self.appID = nil
        self.type = nil
    }
    
    /// Whether or not the value in the `token` property is expired.
    public var tokenExpired: Bool {
        return self.expiresAt == nil ? true : Date() <= self.expiresAt!
    }
}
