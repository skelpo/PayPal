import Vapor

/// An invoice, sent by a merchant to a client, for the merchant to receive a payment.ai
public struct Invoice: Content, Equatable {
    
    /// The ID of the invoice.
    public let id: String?
    
    /// The invoice status. When you [search for invoices](https://developer.paypal.com/docs/api/invoicing/#search_search),
    /// you must specify this value as an array. For example, `"status": ["REFUNDED"]`. The status indicates the phase of an invoice in its lifecycle.
    /// The status also indicates whether the invoice is unpaid, partially paid, fully paid, partially refunded, or fully refunded.
    /// An invoice payment can be either:
    /// - **Connected** to an invoice. The customer clicks **Pay** on the invoice to make a payment. The payment is automatically recorded.
    /// - **Disconnected** from an invoice. The customer pays by check, wire transfer, or another method. The merchant manually records the payment.
    ///
    /// Similarly, an invoice refund can be **disconnected** from an invoice. The merchant refunds a payment by check, wire transfer,
    /// or another method and manually records the refund.
    public let status: Status
    
    /// The total amount of the invoice.
    public let total: Amount?
    
    /// An array of payment details for the invoice.
    public let payments: [Details]?
    
    /// An array of refund details for the invoice.
    public let refunds: [RefundDetail]?
    
    /// The audit information for the invoice.
    public let metadata: Metadata?
    
    /// The payment summary of the invoice. Includes the amount paid through PayPal and other sources.
    public let paid: PaymentSummary?
    
    /// The payment summary of the invoice. Includes the amount refunded through PayPal and other sources.
    public let refunded: PaymentSummary?
    
    /// An array of PayPal file IDs for the files that are attached to an invoice. You can attach up to five files.
    public let attachments: [FileAttachment]?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// The invoice number. If you omit this value, the default is the number that the API automatically increments from the last number.
    ///
    /// Maximum length: 25.
    public var number: String?
    
    /// The merchant information, such as business name, email, address, and so on.
    public var merchant: MerchantInfo
    
    /// An array of billing information for the invoice recipient.
    ///
    /// - Note: This value is an array with only one element.
    public var billing: [BillingInfo]?
    
    /// The shipping information for the recipient of the invoice.
    public var shipping: ShippingInfo?
    
    /// An array of email addresses to which PayPal sends a copy of the invoice.
    public var cc: [Participant]?
    
    /// An array of invoice line item information.
    public var items: [Item]?
    
    /// The invoice date as specified by the sender, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public var date: String?
    
    /// The payment due date of the invoice. If you include `due_date`, the `term_type` value is ignored.
    public var payment: PaymentTerm?
    
    /// The reference data, such as PO number.
    ///
    /// Maximum length: 60.
    public var reference: String?
    
    /// The invoice level discount, as a percent or an amount value.
    public var discount: Discount<Amount>?
    
    /// The shipping amount, as a percent or an amount value.
    public var shippingCost: ShippingCosts?
    
    /// The custom amount to apply to an invoice. If you include a label, you must include a custom amount.
    public var custom: CustomAmount<Amount>?
    
    /// Indicates whether the invoice allows a partial payment. If `false`, the invoice must be paid in full. If `true`, the invoice allows partial payments.
    ///
    /// - Note: This feature is not available for merchants in India, Brazil, or Israel.
    public var allowPartialPayment: Bool?
    
    /// The minimum amount allowed for a partial payment. Valid only if `allow_partial_payment` is true.
    public var minimumDue: Amount?
    
    /// Indicates whether the tax is calculated before or after a discount. If `false`, the tax is calculated before a discount.
    /// If `true`, the tax is calculated after a discount.
    public var taxCalculatedAfterDiscount: Bool?
    
    /// Indicates whether the unit price includes tax.
    public var taxInclusive: Bool?
    
    /// The general terms of the invoice.
    ///
    /// Maximum length: 4000.
    public var terms: String?
    
    /// A note to the invoice recipient. The note also appears on the invoice notification email.
    ///
    /// Maximum length: 4000.
    public var note: String?
    
    /// A private bookkeeping memo for the merchant.
    ///
    /// Maximum length: 500.
    public var memo: String?
    
    /// The full URL to an external logo image. The logo must not be larger than 250 pixels wide by 90 pixels high. The logo must be stored on a secure server.
    ///
    /// Maximum length: 4000.
    public var logo: String?
    
    /// Indicates whether the invoice enables the customer to enter a tip amount during payment.
    /// If `true`, the invoice shows a tip amount field so that the customer can enter a tip amount. If `false`, the invoice does not show a tip amount field.
    ///
    /// - Note: This feature is not available for merchants in Hong Kong, Taiwan, India, or Japan.
    public var allowTip: Bool?
    
    /// This value is only used to determine the layout to display on the create or edit invoice experience, such as which fields to show and hide.
    /// It does not impact the view of the invoice that the customer receives.
    ///
    /// - Note: If you are just using the Invoicing APIs to create and send invoices, leave this field blank.
    ///   The `template_id` is only needed if you use the Invoicing API to build a full invoicing solution that includes templates.
    public var template: String?
}
