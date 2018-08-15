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
        public var startInvoiceAt: String?
        
        /// The end date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var endInvoiceAt: String?
        
        /// The start due date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var startDueAt: String?
        
        /// The end due date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var endDueAt: String?
        
        /// The start payment date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var startPaymentAt: String?
        
        /// The end payment date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var endPaymentAt: String?
        
        /// The start creation date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var startCreationAt: String?
        
        /// The end creation date for the invoice, in
        /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, yyyy-MM-dd z.
        public var endCreationAt: String?
        
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
            startInvoiceAt: String? = nil,
            endInvoiceAt: String? = nil,
            startDueAt: String? = nil,
            endDueAt: String? = nil,
            startPaymentAt: String? = nil,
            endPaymentAt: String? = nil,
            startCreationAt: String? = nil,
            endCreationAt: String? = nil,
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
            self.startInvoiceAt = startInvoiceAt
            self.endInvoiceAt = endInvoiceAt
            self.startDueAt = startDueAt
            self.endDueAt = endDueAt
            self.startPaymentAt = startPaymentAt
            self.endPaymentAt = endPaymentAt
            self.startCreationAt = startCreationAt
            self.endCreationAt = endCreationAt
            self.page = page
            self.pageSize = pageSize
            self.totalCount = totalCount
            self.archived = archived
        }
    }
}
