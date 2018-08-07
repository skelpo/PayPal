import Vapor

/// Log In with PayPal (formerly PayPal Access) is a commerce identity solution that enables your customers to sign in to your web site quickly
/// and securely using their PayPal login credentials. Log In with PayPal utilizes the latest security standards, and you don't have to worry
/// about storing user data on your system.
///
/// For more information, learn about [Log In with PayPal](https://developer.paypal.com/docs/integration/direct/identity/).
public final class Identity: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"customer/disputes"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "identity"
    }
}
