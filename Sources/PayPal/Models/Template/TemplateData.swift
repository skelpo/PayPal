import Vapor

extension Template {
    
    /// The data used to populate an invoice template.
    public struct Data: Content, Equatable {
        
        /// The currency and amount of the invoice total.
        public let total: CurrencyAmount?
        
        
        /// The merchant business information that appears on the invoice.
        public var merchant: MerchantInfo
        
        /// The billing information of the invoice recipient.
        ///
        /// - Note: This value is an array with only one element.
        public var billing: [BillingInfo]?
        
        /// The shipping information for the invoice recipient.
        public var shipping: ShippingInfo?
        
        /// An array of email addresses to which PayPal sends a copy of the invoice.
        public var cc: [Email]?
        
        /// An array of invoice line item information. The maximum items for an invoice is `100`.
        public var items: [Invoice.Item]?
        
        /// The payment term of the invoice. If you specify `term_type`, you cannot specify `due_date`, and vice versa.
        public var payment: PaymentTerm?
        
        /// The reference data, such as a PO number.
        ///
        /// Maximum length: 60.
        public var reference: Failable<String?, NotNilValidate<Length60>>
        
        /// The invoice level discount, as a percent or an amount value.
        public var discount: Discount<CurrencyAmount>?
        
        /// The shipping cost, as a percent or an amount value.
        public var shippingCost: ShippingCosts?
        
        /// The custom amount to apply to an invoice. If you include a label, you must include a custom amount.
        public var custom: CustomAmount<CurrencyKeys>?
        
        /// Indicates whether the invoice allows a partial payment. If `false`,
        /// the invoice must be paid in full. If `true`, the invoice allows partial payments.
        ///
        /// - Note: This feature is not available for merchants in India, Brazil, or Israel.
        public var allowPartialPayment: Bool?
        
        /// The currency and amount of the minimum allowed for a partial payment. Valid only when `allow_partial_payment` is `true`.
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
        
        /// A note to the invoice recipient. This note also appears on the invoice notification email.
        ///
        /// Maximum length: 4000.
        public var note: Failable<String?, NotNilValidate<Length4000>>
        
        /// A private bookkeeping memo for the merchant.
        ///
        /// Maximum length: 150.
        public var memo: Failable<String?, NotNilValidate<Length150>>
        
        /// The full URL to an external logo image. The logo image must not be larger than 250 pixels wide by 90 pixels high.
        ///
        /// Maximum length: 4000.
        public var logo: Failable<String?, NotNilValidate<Length4000>>
        
        /// An array of PayPal file IDs for the files that are attached to an invoice. The maximum number of files is `5`.
        public var attachments: [FileAttachment]?
        
        
        /// Creates a new `Invoice` instance.
        ///
        /// - Parameters:
        ///   - merchant: The merchant business information that appears on the invoice.
        ///   - billing: The billing information of the invoice recipient.
        ///   - shipping: The shipping information for the invoice recipient.
        ///   - cc: An array of email addresses to which PayPal sends a copy of the invoice.
        ///   - items: An array of invoice line item information.
        ///   - payment: The payment term of the invoice.
        ///   - reference: The reference data, such as a PO number.
        ///   - discount: The invoice level discount, as a percent or an amount value.
        ///   - shippingCost: The shipping cost, as a percent or an amount value.
        ///   - custom: The custom amount to apply to an invoice.
        ///   - allowPartialPayment: Indicates whether the invoice allows a partial payment.
        ///   - minimumDue: The currency and amount of the minimum allowed for a partial payment.
        ///   - taxCalculatedAfterDiscount: Indicates whether the tax is calculated before or after a discount.
        ///   - taxInclusive: Indicates whether the unit price includes tax.
        ///   - terms: The general terms of the invoice.
        ///   - note: A note to the invoice recipient.
        ///   - memo: A private bookkeeping memo for the merchant.
        ///   - logo: The full URL to an external logo image.
        ///   - attachments: An array of PayPal file IDs for the files that are attached to an invoice.
        public init(
            merchant: MerchantInfo,
            billing: [BillingInfo]? = nil,
            shipping: ShippingInfo? = nil,
            cc: [Email]? = nil,
            items: [Invoice.Item]? = nil,
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
            memo: Failable<String?, NotNilValidate<Length150>> = nil,
            logo: Failable<String?, NotNilValidate<Length4000>> = nil,
            attachments: [FileAttachment]? = nil
        ) {
            self.total = nil
            
            self.merchant = merchant
            self.billing = billing
            self.shipping = shipping
            self.cc = cc
            self.items = items
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
            self.attachments = attachments
        }
        
        enum CodingKeys: String, CodingKey {
            case items, reference, discount, custom, terms, note, attachments
            case merchant = "merchant_info"
            case billing = "billing_info"
            case shipping = "shipping_info"
            case cc = "cc_info"
            case payment = "payment_term"
            case shippingCost = "shipping_cost"
            case allowPartialPayment = "allow_partial_payment"
            case minimumDue = "minimum_amount_due"
            case taxCalculatedAfterDiscount = "tax_calculated_after_discount"
            case taxInclusive = "tax_inclusive"
            case memo = "merchant_memo"
            case logo = "logo_url"
            case total = "total_amount"
        }
    }
}
