import Vapor

/// Log In with PayPal (formerly PayPal Access) is a commerce identity solution that enables your customers to sign in to your web site quickly
/// and securely using their PayPal login credentials. Log In with PayPal utilizes the latest security standards, and you don't have to worry
/// about storing user data on your system.
///
/// For more information, learn about [Log In with PayPal](https://developer.paypal.com/docs/integration/direct/identity/).
public final class Identity: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"identity"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.version`.
    public let version: Version
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "identity"
        self.version = try container.make(Configuration.self).version || .v1
    }
    
    /// Retrieves the authenticated user's profile attributes.
    ///
    /// - Returns: A `UserInfo` object, containing user profile attributes. The attributes returned depend on the scopes configured for the REST app.
    ///   For example, if the `address` scope is not configured for the app, the response does not include the `address` attribute.
    public func info() -> Future<UserInfo> {
        return self.client { client in
            return client.get(self.path + "openidconnect/userinfo", parameters: QueryParamaters(custom: ["schema": "openid"]), as: UserInfo.self)
        }
    }
}
