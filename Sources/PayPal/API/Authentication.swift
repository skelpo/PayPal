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
        return self.expiresAt == nil ? true : Date() > self.expiresAt!
    }
}

internal struct AuthResponse: Content {
    let scope: String
    let access_token: String
    let token_type: String
    let app_id: String
    let expires_in: Double
    
    func populate(_ info: AuthInfo) {
        info.scopes = self.scope.split(separator: " ").map(String.init)
        info.token = self.access_token
        info.type = self.token_type
        info.appID = self.app_id
        info.expiresAt = Date(timeIntervalSinceNow: self.expires_in)
    }
}

extension PayPalClient {
    public func authenticate() -> Future<Void> {
        return Future.flatMap(on: self.container) { () -> Future<Response> in
            let config = try self.container.make(Configuration.self)
            
            let credentials = "\(config.id):\(config.secret)"
            let encoded = Data(credentials.utf8).base64EncodedString()
            let headers: HTTPHeaders = ["Accept": "application/json", "Accept-Language": "en_US", "Authorization": "Basic \(encoded)"]
            
            let request = try self.container.paypal(.POST, "v1/oauth2/token", headers: headers, auth: false, body: ["grant_type": "client_credentials"])
            return try self.container.client().send(request)
            
        }.flatMap(to: AuthResponse.self) { response in
            return try response.content.decode(AuthResponse.self)
            
        }.map(to: Void.self) { data in
            let auth = try self.container.make(AuthInfo.self)
            data.populate(auth)
        }
    }
}
