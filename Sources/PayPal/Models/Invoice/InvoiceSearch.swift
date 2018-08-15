import Vapor

extension Invoice {
    public struct Search: Content, Equatable {
        public var email: String?
        public var firstName: String?
        public var lastName: String?
        public var businessName: String?
        public var number: String?
        public var status: Status?
        public var lowerAmount: String?
        public var upperAmount: String?
        public var startInvoiceAt: String?
        public var endInvoiceAt: String?
        public var startDueAt: String?
        public var endDueAt: String?
        public var startPaymentAt: String?
        public var endPaymentAt: String?
        public var startCreationAt: String?
        public var endCreationAt: String?
        public var page: Int?
        public var pageSize: Int?
        public var totalCount: Bool?
        public var archived: Bool?
        
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
