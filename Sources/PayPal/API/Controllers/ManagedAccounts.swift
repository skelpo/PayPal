import Vapor

/// The Managed Accounts API enables a marketplace to add PayPal merchant accounts.
///
/// - Warning: PayPal for Marketplaces is a limited-release solution at this time. It is available to select partners for approved use cases.
///   For more information, reach out to your PayPal account manager or [contact us](https://www.paypal.com/us/webapps/mpp/partner-program/contact-us).
///
/// Supports the Connected path and Managed path marketplace models:
///
/// - With [Connected path](https://developer.paypal.com/docs/marketplaces/integrate/connected/), you host a button on your website that takes sellers
///   to PayPal to create and configure a PayPal account. The Onboarding API enables you to collect seller data and pass it to the account creation
///   and setup forms, reducing the burden on sellers during the signup and setup process.
/// - With [Managed Path](https://developer.paypal.com/docs/marketplaces/integrate/managed/), you create and configure reference accounts
///   that enable you to make payments to sellers on your platform. The Managed Accounts API enables you to create reference accounts
///   without involving your sellers.
///
/// You can call the [create merchant account](https://developer.paypal.com/docs/api/managed-accounts/v1/#partner-merchant_create),
/// [repopulate merchant account](https://developer.paypal.com/docs/api/managed-accounts/v1/#partner-merchant_repopulate),
/// and [update merchant account](https://developer.paypal.com/docs/api/managed-accounts/v1/#partner-merchant_update) API methods for the Managed path.
public final class MerchentAccounts: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"partners/merchant-accounts"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "partners/merchant-accounts"
    }
}

