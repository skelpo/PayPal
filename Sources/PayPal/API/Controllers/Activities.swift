import Vapor

/// An interface for the PayPal Activities API.
///
/// Activities are records for all payments, currency transfers,
/// money conversions, requests for payments, and promises of payments.
/// [Further reading](https://developer.paypal.com/docs/api/activities/v1/).
public final class Activities: PayPalController {
    public var container: Container
    public var resource: String
    
    public init(container: Container) {
        self.container = container
        self.resource = "activities"
    }
}
