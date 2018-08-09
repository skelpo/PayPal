import Vapor

extension Invoice {
    
    /// Audit information for an invoice.
    public struct Metadata: Content, Equatable {
        
        /// The date and time when the resource was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let createdAt: String?
        
        /// The email address of the account that created the resource.
        public let createdBy: String?
        
        /// The date and time when the resource was canceled, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let cancelledAt: String?
        
        /// The actor who canceled the resource.
        public let cancelledBy: String?
        
        /// The date and time when the resource was last edited, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let lastUpdatedAt: String?
        
        /// The email address of the account that last edited the resource.
        public let lastUpdatedBy: String?
        
        /// The date and time when the resource was first sent, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let firstSentDate: String?
        
        /// The date and time when the resource was last sent, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let lastSentDate: String?
        
        /// The email address of the account that last sent the resource.
        public let lastSentBy: String?
        
        /// The URL for the payer's view of the invoice.
        public let payerView: String?
    }
}
