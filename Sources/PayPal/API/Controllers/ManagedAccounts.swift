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
public final class ManagedAccounts: PayPalController {
    
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
    
    /// Creates a merchant account. Submit the merchant account information in the JSON request body.
    ///
    /// A successful request returns the HTTP `201 Created` status code and a JSON response body that shows merchant account details.
    ///
    /// - Parameter account: The data for the account to create.
    ///
    /// - Returns: Creation success information, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func create(account: MerchantAccount) -> Future<CreatedMerchantResponse> {
        return Future.flatMap(on: self.container) { () -> Future<CreatedMerchantResponse> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path(), body: account, as: CreatedMerchantResponse.self)
        }
    }
    
    /// Partially updates information for a merchant account, by merchant payer ID. For information about the paths where you can replace, add,
    /// or delete information, see update account in the [update account](https://developer.paypal.com/docs/marketplaces/how-to/update-reference-accounts/)
    /// in the Managed Onboarding Integration Guide.
    ///
    /// A successful request returns the HTTP `204 No Content` status code with no JSON response body.
    ///
    /// - Parameters:
    ///   - id: The ID of the merchant to update.
    ///   - patches: An array of JSON patch objects to apply partial updates to resources.
    ///
    /// - Returns: The HTTP status code of the response, which will be `204 No Content`. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func patch(account id: String, with patchs: [Patch]) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            let client = try self.container.make(PayPalClient.self)
            return try client.patch(self.path() + id, body: ["patch_request": patchs], as: HTTPStatus.self)
        }
    }
    
    /// Updates merchant account information, by merchant payer ID. Specify the information to update in the JSON request body.
    ///
    /// A successful request returns the HTTP `204 No Content` status code with no JSON response body.
    ///
    /// - Parameters:
    ///   - id: The payer ID of the merchant for which to update account information.
    ///   - data: The new data for the merchant account.
    ///
    /// - Returns: The HTTP status code of the response, which will be `204 No Content`. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func update(account id: String, with data: MerchantAccount) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            let client = try self.container.make(PayPalClient.self)
            return try client.put(self.path() + id, body: data, as: HTTPStatus.self)
        }
    }
    
    /// Shows details for a merchant account, by merchant payer ID.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows merchant account details.
    ///
    /// - Parameter accountID: The payer ID of the merchant for which to show account details.
    ///
    /// - Returns: The data for the merchant account, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func details(for accountID: String) -> Future<MerchantAccount> {
        return Future.flatMap(on: self.container) { () -> Future<MerchantAccount> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path() + accountID, as: MerchantAccount.self)
        }
    }
}

