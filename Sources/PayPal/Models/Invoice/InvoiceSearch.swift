import Vapor

extension Invoice {
    
    /// The criteria that an invoice search must match.
    public struct Search: Content, Equatable {
        
        /// The initial letters of the email address.
        public var email: String?
        
        /// The initial letters of the recipient's first name.
        public var firstName: String?
        
        /// The initial letters of the recipient's last name.
        public var lastName: String?
        
        /// The initial letters of the recipient's business name.
        public var businessName: String?
        
        /// Any part of the invoice number.
        public var number: String?
        
        /// The invoice status. To search by status, specify this value as an array. For example, `"status": ["REFUNDED"]`.
        /// The status indicates the phase of the invoice in its lifecycle:
        public var status: Status?
        
        /// The lower limit of the total amount.
        public var lowerAmount: String?
        
        /// The upper limit of the total amount.
        public var upperAmount: String?
        
        /// The start date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var startInvoiceAt: ISO8601Date?
        
        /// The end date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var endInvoiceAt: ISO8601Date?
        
        /// The start due date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var startDueAt: ISO8601Date?
        
        /// The end due date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var endDueAt: ISO8601Date?
        
        /// The start payment date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var startPaymentAt: ISO8601Date?
        
        /// The end payment date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var endPaymentAt: ISO8601Date?
        
        /// The start creation date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var startCreationAt: ISO8601Date?
        
        /// The end creation date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var endCreationAt: ISO8601Date?
        
        /// The zero-relative start index of the entire list of merchant invoices to return in the response. So, a combination of `page=0`
        /// and `page_size=20` returns the first 20 invoices. A combination of `page=20` and `page_size=20` returns the next 20 invoices.
        public var page: Int?
        
        /// The page size for the search results.
        public var pageSize: Int?
        
        /// Indicates whether the response shows the total count.
        public var totalCount: Bool?
        
        /// Indicates whether to list merchant-archived invoices in the response. If `true`, response lists only merchant-archived invoices.
        /// If `false`, response lists only unarchived invoices. If `null`, response lists all invoices.
        public var archived: Bool?
        
        
        /// Creates a new `Invoice.Search` instance.
        ///
        /// All paramaters have a default value of `nil`, so you only need to pass in the values you want to search with.
        public init(
            email: String? = nil,
            firstName: String? = nil,
            lastName: String? = nil,
            businessName: String? = nil,
            number: String? = nil,
            status: Status? = nil,
            lowerAmount: String? = nil,
            upperAmount: String? = nil,
            startInvoiceAt: Date? = nil,
            endInvoiceAt: Date? = nil,
            startDueAt: Date? = nil,
            endDueAt: Date? = nil,
            startPaymentAt: Date? = nil,
            endPaymentAt: Date? = nil,
            startCreationAt: Date? = nil,
            endCreationAt: Date? = nil,
            page: Int? = nil,
            pageSize: Int? = nil,
            totalCount: Bool? = nil,
            archived: Bool? = nil
        ) {
            self.email = email
            self.firstName = firstName
            self.lastName = lastName
            self.businessName = businessName
            self.number = number
            self.status = status
            self.lowerAmount = lowerAmount
            self.upperAmount = upperAmount
            self.startInvoiceAt = startInvoiceAt == nil ? nil : ISO8601Date(startInvoiceAt!)
            self.endInvoiceAt = endInvoiceAt == nil ? nil : ISO8601Date(endInvoiceAt!)
            self.startDueAt = startDueAt == nil ? nil : ISO8601Date(startDueAt!)
            self.endDueAt = endDueAt == nil ? nil : ISO8601Date(endDueAt!)
            self.startPaymentAt = startPaymentAt == nil ? nil : ISO8601Date(startPaymentAt!)
            self.endPaymentAt = endPaymentAt == nil ? nil : ISO8601Date(endPaymentAt!)
            self.startCreationAt = startCreationAt == nil ? nil : ISO8601Date(startCreationAt!)
            self.endCreationAt = endCreationAt == nil ? nil : ISO8601Date(endCreationAt!)
            self.page = page
            self.pageSize = pageSize
            self.totalCount = totalCount
            self.archived = archived
        }
        
        enum CodingKeys: String, CodingKey {
            case email, number, status, page, archived
            case firstName = "recipient_first_name"
            case lastName = "recipient_last_name"
            case businessName = "recipient_business_name"
            case lowerAmount = "lower_total_amount"
            case upperAmount = "upper_total_amount"
            case startInvoiceAt = "start_invoice_date"
            case endInvoiceAt = "end_invoice_date"
            case startDueAt = "start_due_date"
            case endDueAt = "end_due_date"
            case startPaymentAt = "start_payment_date"
            case endPaymentAt = "end_payment_date"
            case startCreationAt = "start_creation_date"
            case endCreationAt = "end_creation_date"
            case pageSize = "page_size"
            case totalCount = "total_count_required"
        }
    }
}
