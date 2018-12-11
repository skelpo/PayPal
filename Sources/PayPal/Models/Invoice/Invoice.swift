import Vapor

/// An invoice, sent by a merchant to a client, for the merchant to receive a payment.ai
public struct Invoice: Content, Equatable {
    
    /// The ID of the invoice.
    public let id: String?
    
    /// The invoice status. When you [search for invoices](https://developer.paypal.com/docs/api/invoicing/#search_search),
    /// you must specify this value as an array. For example, `"status": ["REFUNDED"]`. The status indicates the phase of an invoice in its lifecycle.
    /// The status also indicates whether the invoice is unpaid, partially paid, fully paid, partially refunded, or fully refunded.
    ///
    /// An invoice payment can be either:
    /// - **Connected** to an invoice. The customer clicks **Pay** on the invoice to make a payment. The payment is automatically recorded.
    /// - **Disconnected** from an invoice. The customer pays by check, wire transfer, or another method. The merchant manually records the payment.
    ///
    /// Similarly, an invoice refund can be **disconnected** from an invoice. The merchant refunds a payment by check, wire transfer,
    /// or another method and manually records the refund.
    public let status: Status?
    
    /// The total amount of the invoice.
    public let total: CurrencyAmount?
    
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
    public var number: Int?
    
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
    public var date: Date?
    
    /// The payment due date of the invoice. If you include `due_date`, the `term_type` value is ignored.
    public var payment: PaymentTerm?
    
    /// The reference data, such as PO number.
    ///
    /// Maximum length: 60.
    public var reference: Failable<String?, NotNilValidate<Length60>>
    
    /// The invoice level discount, as a percent or an amount value.
    public var discount: Discount<CurrencyAmount>?
    
    /// The shipping amount, as a percent or an amount value.
    public var shippingCost: ShippingCosts?
    
    /// The custom amount to apply to an invoice. If you include a label, you must include a custom amount.
    public var custom: CustomAmount<CurrencyKeys>?
    
    /// Indicates whether the invoice allows a partial payment. If `false`, the invoice must be paid in full.
    /// If `true`, the invoice allows partial payments.
    ///
    /// - Note: This feature is not available for merchants in India, Brazil, or Israel.
    public var allowPartialPayment: Bool?
    
    /// The minimum amount allowed for a partial payment. Valid only if `allow_partial_payment` is true.
    public var minimumDue: CurrencyAmount?
    
    /// Indicates whether the tax is calculated before or after a discount. If `false`, the tax is calculated before a discount.
    /// If `true`, the tax is calculated after a discount.
    public var taxCalculatedAfterDiscount: Bool?
    
    /// Indicates whether the unit price includes tax.
    public var taxInclusive: Bool?
    
    /// The general terms of the invoice.
    ///
    /// Maximum length: 4000.
    public var terms: Failable<String?, NotNilValidate<Length4000>>
    
    /// A note to the invoice recipient. The note also appears on the invoice notification email.
    ///
    /// Maximum length: 4000.
    public var note: Failable<String?, NotNilValidate<Length4000>>
    
    /// A private bookkeeping memo for the merchant.
    ///
    /// Maximum length: 500.
    public var memo: Failable<String?, NotNilValidate<Length500>>
    
    /// The full URL to an external logo image. The logo must not be larger than 250 pixels wide
    /// by 90 pixels high. The logo must be stored on a secure server.
    ///
    /// Maximum length: 4000.
    public var logo: Failable<String?, NotNilValidate<Length4000>>
    
    /// Indicates whether the invoice enables the customer to enter a tip amount during payment.
    /// If `true`, the invoice shows a tip amount field so that the customer can enter a tip amount.
    /// If `false`, the invoice does not show a tip amount field.
    ///
    /// - Note: This feature is not available for merchants in Hong Kong, Taiwan, India, or Japan.
    public var allowTip: Bool?
    
    /// This value is only used to determine the layout to display on the create or edit invoice experience, such as which fields to show and hide.
    /// It does not impact the view of the invoice that the customer receives.
    ///
    /// - Note: If you are just using the Invoicing APIs to create and send invoices, leave this field blank.
    ///   The `template_id` is only needed if you use the Invoicing API to build a full invoicing solution that includes templates.
    public var template: String?
    
    
    /// Creates a new `Invoice` instance.
    ///
    /// - Parameters:
    ///   - number: The invoice number.
    ///   - merchant: The merchant information, such as business name, email, address, and so on.
    ///   - billing: An array of billing information for the invoice recipient.
    ///   - shipping: The shipping information for the recipient of the invoice.
    ///   - cc: An array of email addresses to which PayPal sends a copy of the invoice.
    ///   - items: An array of invoice line item information.
    ///   - date: The invoice date as specified by the sender, in Internet date and time format.
    ///   - payment: The payment due date of the invoice.
    ///   - reference: The reference data, such as PO number.
    ///   - discount: The invoice level discount, as a percent or an amount value.
    ///   - shippingCost: The shipping amount, as a percent or an amount value.
    ///   - custom: The custom amount to apply to an invoice.
    ///   - allowPartialPayment: Indicates whether the invoice allows a partial payment.
    ///   - minimumDue: The minimum amount allowed for a partial payment.
    ///   - taxCalculatedAfterDiscount: Indicates whether the tax is calculated before or after a discount.
    ///   - taxInclusive: Indicates whether the unit price includes tax.
    ///   - terms: The general terms of the invoice.
    ///   - note: A note to the invoice recipient.
    ///   - memo: A private bookkeeping memo for the merchant.
    ///   - logo: The full URL to an external logo image.
    ///   - allowTip: Indicates whether the invoice enables the customer to enter a tip amount during payment.
    ///   - template: This value is only used to determine the layout to display on the create or edit invoice experience.
    public init(
        number: Int? = nil,
        merchant: MerchantInfo,
        billing: [BillingInfo]? = nil,
        shipping: ShippingInfo? = nil,
        cc: [Participant]? = nil,
        items: [Item]? = nil,
        date: Date? = nil,
        payment: PaymentTerm? = nil,
        reference: Failable<String?, NotNilValidate<Length60>> = nil,
        discount: Discount<CurrencyAmount>? = nil,
        shippingCost: ShippingCosts? = nil,
        custom: CustomAmount<CurrencyKeys>? = nil,
        allowPartialPayment: Bool? = nil,
        minimumDue: CurrencyAmount? = nil,
        taxCalculatedAfterDiscount: Bool? = nil,
        taxInclusive: Bool? = nil,
        terms: Failable<String?, NotNilValidate<Length4000>> = nil,
        note: Failable<String?, NotNilValidate<Length4000>> = nil,
        memo: Failable<String?, NotNilValidate<Length500>> = nil,
        logo: Failable<String?, NotNilValidate<Length4000>> = nil,
        allowTip: Bool? = nil,
        template: String? = nil
    ) {
        self.id = nil
        self.status = nil
        self.total = nil
        self.payments = nil
        self.refunds = nil
        self.metadata = nil
        self.paid = nil
        self.refunded = nil
        self.attachments = nil
        self.links = nil
        
        self.number = number
        self.merchant = merchant
        self.billing = billing
        self.shipping = shipping
        self.cc = cc
        self.items = items
        self.date = date
        self.payment = payment
        self.reference = reference
        self.discount = discount
        self.shippingCost = shippingCost
        self.custom = custom
        self.allowPartialPayment = allowPartialPayment
        self.minimumDue = minimumDue
        self.taxCalculatedAfterDiscount = taxCalculatedAfterDiscount
        self.taxInclusive = taxInclusive
        self.terms = terms
        self.note = note
        self.memo = memo
        self.logo = logo
        self.allowTip = allowTip
        self.template = template
    }
    
    enum CodingKeys: String, CodingKey {
        case id, number, status, items, reference, discount, custom, terms, note, payments, refunds, metadata, attachments, links
        case merchant = "merchant_info"
        case billing = "billing_info"
        case shipping = "shipping_info"
        case cc = "cc_info"
        case date = "invoice_date"
        case payment = "payment_term"
        case shippingCost = "shipping_cost"
        case allowPartialPayment = "allow_partial_payment"
        case minimumDue = "minimum_amount_due"
        case taxCalculatedAfterDiscount = "tax_calculated_after_discount"
        case taxInclusive = "tax_inclusive"
        case memo = "merchant_memo"
        case logo = "logo_url"
        case total = "total_amount"
        case paid = "paid_amount"
        case refunded = "refunded_amount"
        case allowTip = "allow_tip"
        case template = "template_id"
    }
}
