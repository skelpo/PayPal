import Vapor

extension Template {
    
    /// The data used to populate an invoice template.
    public struct Data: Content, ValidationSetable, Equatable {
        
        /// The currency and amount of the invoice total.
        public let total: Amount?
        
        
        /// The merchant business information that appears on the invoice.
        public var merchant: MerchantInfo
        
        /// The billing information of the invoice recipient.
        ///
        /// - Note: This value is an array with only one element.
        public var billing: [BillingInfo]?
        
        /// The shipping information for the invoice recipient.
        public var shipping: ShippingInfo?
        
        /// An array of email addresses to which PayPal sends a copy of the invoice.
        public var cc: [CCEmail]?
        
        /// An array of invoice line item information. The maximum items for an invoice is `100`.
        public var items: [Invoice.Item]?
        
        /// The payment term of the invoice. If you specify `term_type`, you cannot specify `due_date`, and vice versa.
        public var payment: PaymentTerm?
        
        /// The reference data, such as a PO number.
        ///
        /// This property can be set using the `Template.Data.set(_:)` method
        /// which will validate the new valie before asigning it to the property.
        ///
        /// Maximum length: 60.
        public private(set) var reference: String?
        
        /// The invoice level discount, as a percent or an amount value.
        public var discount: Discount<Amount>?
        
        /// The shipping cost, as a percent or an amount value.
        public var shippingCost: ShippingCosts?
        
        /// The custom amount to apply to an invoice. If you include a label, you must include a custom amount.
        public var custom: CustomAmount<Amount>?
        
        /// Indicates whether the invoice allows a partial payment. If `false`, the invoice must be paid in full. If `true`, the invoice allows partial payments.
        ///
        /// - Note: This feature is not available for merchants in India, Brazil, or Israel.
        public var allowPartialPayment: Bool?
        
        /// The currency and amount of the minimum allowed for a partial payment. Valid only when `allow_partial_payment` is `true`.
        public var minimumDue: Amount?
        
        /// Indicates whether the tax is calculated before or after a discount. If `false`, the tax is calculated before a discount.
        /// If `true`, the tax is calculated after a discount.
        public var taxCalculatedAfterDiscount: Bool?
        
        /// Indicates whether the unit price includes tax.
        public var taxInclusive: Bool?
        
        /// The general terms of the invoice.
        ///
        /// This property can be set using the `Template.Data.set(_:)` method
        /// which will validate the new valie before asigning it to the property.
        ///
        /// Maximum length: 4000.
        public private(set) var terms: String?
        
        /// A note to the invoice recipient. This note also appears on the invoice notification email.
        ///
        /// This property can be set using the `Template.Data.set(_:)` method
        /// which will validate the new valie before asigning it to the property.
        ///
        /// Maximum length: 4000.
        public private(set) var note: String?
        
        /// A private bookkeeping memo for the merchant.
        ///
        /// This property can be set using the `Template.Data.set(_:)` method
        /// which will validate the new valie before asigning it to the property.
        ///
        /// Maximum length: 150.
        public private(set) var memo: String?
        
        /// The full URL to an external logo image. The logo image must not be larger than 250 pixels wide by 90 pixels high.
        ///
        /// This property can be set using the `Template.Data.set(_:)` method
        /// which will validate the new valie before asigning it to the property.
        ///
        /// Maximum length: 4000.
        public private(set) var logo: String?
        
        /// An array of PayPal file IDs for the files that are attached to an invoice. The maximum number of files is `5`.
        public var attachments: [FileAttachment]?
        
        
        /// Creates a new `Invoice` instance.
        ///
        ///     let data = try Template.Data(
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
        ///         cc: [CCEmail(email: "collective@vapor.codes"), CCEmail(email: "donator@example.com")],
        ///         items: nil,
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
        ///         attachments: [FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")],
        ///     )
        public init(
            merchant: MerchantInfo,
            billing: [BillingInfo]? = nil,
            shipping: ShippingInfo? = nil,
            cc: [CCEmail]? = nil,
            items: [Invoice.Item]? = nil,
            payment: PaymentTerm? = nil,
            reference: String? = nil,
            discount: Discount<Amount>? = nil,
            shippingCost: ShippingCosts? = nil,
            custom: CustomAmount<Amount>? = nil,
            allowPartialPayment: Bool? = nil,
            minimumDue: Amount? = nil,
            taxCalculatedAfterDiscount: Bool? = nil,
            taxInclusive: Bool? = nil,
            terms: String? = nil,
            note: String? = nil,
            memo: String? = nil,
            logo: String? = nil,
            attachments: [FileAttachment]? = nil
        )throws {
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
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Template.Data> {
            var validations = SetterValidations(Data.self)
            
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
                guard memo?.count ?? 0 <= 150 else {
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
    }
}
