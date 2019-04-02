import Failable
import PayPal

/// The payment information for an order.
public struct PurchaseUnit: Codable {
    
    /// The ID for the purchase unit. Required for multiple `purchase_units` or if an order must be updated by using `PATCH`.
    /// If you omit the `reference_id` for an order with one purchase unit, PayPal sets the `reference_id` to `default`.
    public var reference: Failable<String?, NotNilValidate<Length256>>
    
    /// The total order amount with an optional breakdown that provides details, such as the total item amount,
    /// total tax amount, shipping, handling, insurance, and discounts, if any.
    ///
    /// If you specify `amount.breakdown`, the amount equals `item_total` plus `tax_total` plus `shipping` plus `handling`
    /// plus `insurance` minus `shipping_discount`.
    ///
    /// The amount must be a positive number. For listed of supported currencies and decimal precision,
    /// see the PayPal REST APIs [Currency Codes](https://developer.paypal.com/docs/integration/direct/rest/currency-codes/).
    public var amount: DetailedAmount
    
    /// The merchant who receives payment for this transaction.
    public var payee: PayeeBase?
    
    /// Any additional payment instructions for PayPal for Partner customers. Enables features for partners and marketplaces,
    /// such as delayed disbursement and collection of a platform fee. Applies during order creation for captured payments
    /// or during capture of authorized payments.
    public var paymentInstruction: PaymentInstruction?
    
    /// The purchase description.
    public var description: Optional127String
    
    /// The API caller-provided external ID. Used to reconcile client transactions with PayPal transactions.
    /// Appears in transaction and settlement reports but is not visible to the payer.
    public var customID: Optional127String
    
    /// The API caller-provided external invoice number for this order. Appears in both the payer's transaction history
    /// and the emails that the payer receives.
    public var invoice: Optional127String
    
    /// The payment descriptor on the customer's credit card statement of account transactions.
    ///
    /// The maximum length of the soft descriptor is 22 characters. Of this, the PayPal prefix uses eight characters
    /// (PAYPAL *) of the data format. Thus, the maximum length of the soft descriptor information that you can pass
    /// in this field is:
    ///
    ///     22 - length(<PayPal *>) - length(<soft descriptor set in profile> + 1)
    ///
    /// For example, assume the following conditions:
    /// - The PayPal prefix toggle is "PAYPAL *".
    /// - The merchant descriptor set in the Profile is VENMO.
    /// - The soft descriptor is passed in as JanesFlowerGifts LLC.
    ///
    ///     PAYPAL *VENMO JanesFlo
    ///
    /// If the total length of the soft_descriptor exceeds 22 characters, the overflow will be truncated.
    public var softDescriptor: Failable<String?, NotNilValidate<Length22>>
    
    /// An array of items that the customer is purchasing from the merchant.
    public var items: [Order.Item]?
    
    /// The name and address of the person to whom to ship the items.
    public var shipping: Shipping?
    
    /// Creates a new `PurchaseUnit` instance.
    ///
    /// - Parameters:
    ///   - reference: The ID for the purchase unit.
    ///   - amount: The total order amount with an optional breakdown that provides details.
    ///   - payee: The merchant who receives payment for this transaction.
    ///   - paymentInstruction: Any additional payment instructions for PayPal for Partner customers.
    ///   - description: The purchase description.
    ///   - customID: The API caller-provided external ID.
    ///   - invoice: The API caller-provided external invoice number for this order.
    ///   - softDescriptor: The payment descriptor on the customer's credit card statement of account transactions.
    ///   - items: An array of items that the customer is purchasing from the merchant.
    ///   - shipping: The name and address of the person to whom to ship the items.
    public init(
        reference: Failable<String?, NotNilValidate<Length256>>,
        amount: DetailedAmount,
        payee: PayeeBase?,
        paymentInstruction: PaymentInstruction?,
        description: Optional127String,
        customID: Optional127String,
        invoice: Optional127String,
        softDescriptor: Failable<String?, NotNilValidate<Length22>>,
        items: [Order.Item]?,
        shipping: Shipping?
    ) {
        self.reference = reference
        self.amount = amount
        self.payee = payee
        self.paymentInstruction = paymentInstruction
        self.description = description
        self.customID = customID
        self.invoice = invoice
        self.softDescriptor = softDescriptor
        self.items = items
        self.shipping = shipping
    }
    
    enum CodingKeys: String, CodingKey {
        case amount, payee, description, items, shipping
        case reference = "reference_id"
        case paymentInstruction = "payment_instruction"
        case customID = "custom_id"
        case invoice = "invoice_id"
        case softDescriptor = "soft_descriptor"
    }
}
