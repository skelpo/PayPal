import Vapor

/// Use the Payments REST API to easily and securely accept online and mobile payments.
/// The payments name space contains resource collections for payments, sales, refunds, authorizations, captures, and orders.
///
/// - Important: The use of the PayPal REST /payments APIs to accept credit card payments is restricted.
///   Instead, you can accept credit card payments with [Braintree Direct](https://www.braintreepayments.com/products/braintree-direct).
///
/// You can enable customers to make PayPal and credit card payments with only a few clicks, depending on the country.
/// You can accept an immediate payment or authorize a payment and capture it later. You can show details for completed payments, refunds,
/// and authorizations. You can make full or partial refunds. You also can void or re-authorize authorizations. For more information,
/// see the [Payments overview](https://developer.paypal.com/docs/integration/direct/payments/).
///
/// ## Payment
///
/// Use the `/payment` resource to create a _sale_, an _authorized payment_, or an _order_. A sale is a direct credit card payment,
/// stored credit card payment, or PayPal payment. An authorized payment places funds on hold to be captured later. An order is a purchase
/// that a customer has approved but for which the funds are not placed on hold. You can also use this resource to execute approved
/// PayPal payments and show details for, update, and list payments. For more information, see also
/// [Payments](https://developer.paypal.com/docs/integration/direct/payments/).
public final class Payments: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"payments"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "payments"
    }
    
    internal func path(for resource: Resource)throws -> String {
        return try self.path() + resource.rawValue + "/"
    }
}

extension Payments {
    internal enum Resource: String {
        case payment
        case sale
        case authorization
        case orders
        case capture
        case refund
    }
}
