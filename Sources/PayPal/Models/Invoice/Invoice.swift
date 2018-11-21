import Vapor

/// An invoice, sent by a merchant to a client, for the merchant to receive a payment.ai
public struct Invoice: Content, ValidationSetable, Equatable {
    
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
    ///
    /// This property can be set using the `Invoice.set(_:)` method
    /// which will validate the new valie before asigning it to the property.
    ///
    /// Maximum length: 25.
    public private(set) var number: String?
    
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
    /// This property can be set using the `Invoice.set(_:)` method
    /// which will validate the new valie before asigning it to the property.
    ///
    /// Maximum length: 60.
    public private(set) var reference: String?
    
    /// The invoice level discount, as a percent or an amount value.
    public var discount: Discount<CurrencyAmount>?
    
    /// The shipping amount, as a percent or an amount value.
    public var shippingCost: ShippingCosts?
    
    /// The custom amount to apply to an invoice. If you include a label, you must include a custom amount.
    public var custom: CustomAmount<CurrencyAmount>?
    
    /// Indicates whether the invoice allows a partial payment. If `false`, the invoice must be paid in full. If `true`, the invoice allows partial payments.
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
    /// This property can be set using the `Invoice.set(_:)` method
    /// which will validate the new valie before asigning it to the property.
    ///
    /// Maximum length: 4000.
    public private(set) var terms: String?
    
    /// A note to the invoice recipient. The note also appears on the invoice notification email.
    ///
    /// This property can be set using the `Invoice.set(_:)` method
    /// which will validate the new valie before asigning it to the property.
    ///
    /// Maximum length: 4000.
    public private(set) var note: String?
    
    /// A private bookkeeping memo for the merchant.
    ///
    /// This property can be set using the `Invoice.set(_:)` method
    /// which will validate the new valie before asigning it to the property.
    ///
    /// Maximum length: 500.
    public private(set) var memo: String?
    
    /// The full URL to an external logo image. The logo must not be larger than 250 pixels wide by 90 pixels high. The logo must be stored on a secure server.
    ///
    /// This property can be set using the `Invoice.set(_:)` method
    /// which will validate the new valie before asigning it to the property.
    ///
    /// Maximum length: 4000.
    public private(set) var logo: String?
    
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
    
    
    /// Creates a new `Invoice` instance.
    ///
    ///     let invoice = try Invoice(
    ///         number: nil,
    ///         merchant: MerchantInfo(
    ///             email: "hello@vapor.codes",
    ///             business: "Qutheory LLC.",
    ///             firstName: "Tanner",
    ///             lastName: "Nelson",
    ///             address: nil,
    ///             phone: nil,
    ///             fax: nil,
    ///             website: "https://vapor.codes/",
    ///             taxID: nil,
    ///             info: nil
    ///         ),
    ///         billing: [],
    ///         shipping: nil,
    ///         cc: [Invoice.Participant(email: "collective@vapor.codes"), Invoice.Participant(email: "donator@example.com")],
    ///         items: nil,
    ///         date: now,
    ///         payment: PaymentTerm(type: .dueOnReceipt, due: now),
    ///         reference: "PO number",
    ///         discount: nil,
    ///         shippingCost: nil,
    ///         custom: CustomAmount(label: nil, amount: Amount(currency: .usd, value: "")),
    ///         allowPartialPayment: false,
    ///         minimumDue: Amount(currency: .usd, value: "1.00"),
    ///         taxCalculatedAfterDiscount: true,
    ///         taxInclusive: true,
    ///         terms: nil,
    ///         note: "Thanks for your donation!",
    ///         memo: "Open Collective donation",
    ///         logo: "https://vapor.codes/dist/e032390c38279fbdf18ebf0e763eb44f.png",
    ///         allowTip: true,
    ///         template: "PayPal system template"
    ///     )
    public init(
        number: String? = nil,
        merchant: MerchantInfo,
        billing: [BillingInfo]? = nil,
        shipping: ShippingInfo? = nil,
        cc: [Participant]? = nil,
        items: [Item]? = nil,
        date: String? = nil,
        payment: PaymentTerm? = nil,
        reference: String? = nil,
        discount: Discount<CurrencyAmount>? = nil,
        shippingCost: ShippingCosts? = nil,
        custom: CustomAmount<CurrencyAmount>? = nil,
        allowPartialPayment: Bool? = nil,
        minimumDue: CurrencyAmount? = nil,
        taxCalculatedAfterDiscount: Bool? = nil,
        taxInclusive: Bool? = nil,
        terms: String? = nil,
        note: String? = nil,
        memo: String? = nil,
        logo: String? = nil,
        allowTip: Bool? = nil,
        template: String? = nil
    )throws {
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
        
        try self.set(\.number <~ number)
        try self.set(\.reference <~ reference)
        try self.set(\.terms <~ terms)
        try self.set(\.note <~ note)
        try self.set(\.memo <~ memo)
        try self.set(\.logo <~ logo)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let number = try container.decodeIfPresent(String.self, forKey: .number)
        let reference = try container.decodeIfPresent(String.self, forKey: .reference)
        let terms = try container.decodeIfPresent(String.self, forKey: .terms)
        let note = try container.decodeIfPresent(String.self, forKey: .note)
        let memo = try container.decodeIfPresent(String.self, forKey: .memo)
        let logo = try container.decodeIfPresent(String.self, forKey: .logo)
        
        self.number = number
        self.reference = reference
        self.terms = terms
        self.note = note
        self.memo = memo
        self.logo = logo
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.status = try container.decodeIfPresent(Status.self, forKey: .status)
        self.total = try container.decodeIfPresent(CurrencyAmount.self, forKey: .total)
        self.payments = try container.decodeIfPresent([Details].self, forKey: .payments)
        self.refunds = try container.decodeIfPresent([RefundDetail].self, forKey: .refunds)
        self.metadata = try container.decodeIfPresent(Metadata.self, forKey: .metadata)
        self.paid = try container.decodeIfPresent(PaymentSummary.self, forKey: .paid)
        self.refunded = try container.decodeIfPresent(PaymentSummary.self, forKey: .refunded)
        self.attachments = try container.decodeIfPresent([FileAttachment].self, forKey: .attachments)
        self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)

        self.merchant = try container.decode(MerchantInfo.self, forKey: .merchant)
        self.billing = try container.decodeIfPresent([BillingInfo].self, forKey: .billing)
        self.shipping = try container.decodeIfPresent(ShippingInfo.self, forKey: .shipping)
        self.cc = try container.decodeIfPresent([Participant].self, forKey: .cc)
        self.items = try container.decodeIfPresent([Item].self, forKey: .items)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.payment = try container.decodeIfPresent(PaymentTerm.self, forKey: .payment)
        self.discount = try container.decodeIfPresent(Discount<CurrencyAmount>.self, forKey: .discount)
        self.shippingCost = try container.decodeIfPresent(ShippingCosts.self, forKey: .shippingCost)
        self.custom = try container.decodeIfPresent(CustomAmount<CurrencyAmount>.self, forKey: .custom)
        self.allowPartialPayment = try container.decodeIfPresent(Bool.self, forKey: .allowPartialPayment)
        self.minimumDue = try container.decodeIfPresent(CurrencyAmount.self, forKey: .minimumDue)
        self.taxCalculatedAfterDiscount = try container.decodeIfPresent(Bool.self, forKey: .taxCalculatedAfterDiscount)
        self.taxInclusive = try container.decodeIfPresent(Bool.self, forKey: .taxInclusive)
        self.allowTip = try container.decodeIfPresent(Bool.self, forKey: .allowTip)
        self.template = try container.decodeIfPresent(String.self, forKey: .template)
        
        try self.set(\.number <~ number)
        try self.set(\.reference <~ reference)
        try self.set(\.terms <~ terms)
        try self.set(\.note <~ note)
        try self.set(\.memo <~ memo)
        try self.set(\.logo <~ logo)
    }
    
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<Invoice> {
        var validations = SetterValidations(Invoice.self)
        
        validations.set(\.number) { number in
            guard number?.map(String.init).compactMap(Int.init).count == number?.count else {
                throw PayPalError(status: .badRequest, identifier: "badValue", reason: "`number` property must container a whole number value")
            }
            guard number?.count ?? 0 <= 25 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`number` property must have a length of 25 or less")
            }
        }
        validations.set(\.reference) { reference in
            guard reference?.count ?? 0 <= 60 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`reference` property must have a length of 60 or less")
            }
        }
        validations.set(\.terms) { terms in
            guard terms?.count ?? 0 <= 4_000 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`terms` property must have a length of 4,000 or less")
            }
        }
        validations.set(\.note) { note in
            guard note?.count ?? 0 <= 4_000 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`note` property must have a length of 4,000 or less")
            }
        }
        validations.set(\.memo) { memo in
            guard memo?.count ?? 0 <= 500 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`memo` property must have a length of 500 or less")
            }
        }
        validations.set(\.logo) { logo in
            guard logo?.count ?? 0 <= 4_000 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`logo` property must have a length of 4,000 or less")
            }
        }
        
        return validations
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
