import PayPal
import Vapor

/// As a merchant, you can use the Vault API to securely store customer credit cards in the PayPal vault rather
/// than on your server. When you use the API to store a customer credit card, the API returns the ID of the vaulted card.
/// To make a payment with the vaulted card, you specify this ID instead of credit card details.
/// For information, see the [Vault Integration Guide](https://developer.paypal.com/docs/integration/direct/vault/).
///
/// - Note: PayPal does not validate credit card information that you store in the vault.
///
/// - Warning: The use of the PayPal REST /vault APIs to accept credit card payments is restricted because the
///   merchant must enable but can no longer get approved for the REST direct credit cards (DCC) feature. Instead,
///   you can accept credit card payments with [Braintree Direct](https://www.braintreepayments.com/products/braintree-direct).
///
/// # Credit Cards
///
/// Use the `/credit-cards` resource to store a credit card in the vault, delete, show details for, list,
/// and update vaulted cards.
public final class Valut: VersionedController {

    /// See `VersionedController.client`.
    public var client: PayPalClient

    /// See `VersionedController.resource`
    public var resource: [String]

    /// The controller for the `/vault/credit-cards` resource.
    public var creditCards: CreditCards {
        return CreditCards(client: self.client)
    }

    /// See `VersionedController.init(client:)`.
    public init(client: PayPalClient) {
        self.client = client
        self.resource = ["vault"]
    }
}

extension Valut {

    /// The controller for the `/credit-cards` resource of the Vault API.
    public final class CreditCards: VersionedController {

        /// See `VersionedController.client`.
        public var client: PayPalClient

        /// See `VersionedController.resource`
        public var resource: [String]

        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["vault", "credit-cards"]
        }
    }
}
