import Vapor

extension Invoice {
    
    /// A reminder which a merchant can send to the payer of an invoice.
    public struct Reminder: Content, Equatable {
        
        /// The subject of the notification. Default is a generic subject.
        public var subject: String?
        
        /// A note to the payer.
        public var note: String?
        
        /// Indicates whether to send a copy of the email to the merchant.
        public var sendToMerchant: Bool?
        
        /// An array of one or more CC: emails to which to send notification emails. If you omit this parameter,
        /// the API sends notification emails to all CC: email addresses that are part of the invoice.
        ///
        /// - Note: Valid values are email addresses in the `cc_info` array of the invoice.
        public var emails: [CCEmail]?
        
        /// Creates a new `Invoice.Reminder` instance.
        ///
        ///     Invoice.Reminder(subject: "Invoice Not Sent", note: "Please send the money", emails: [CCEmail(email: "payer@example.com")])
        public init(subject: String?, note: String?, sendToMerchant: Bool? = true, emails: [CCEmail]?) {
            self.subject = subject
            self.note = note
            self.sendToMerchant = sendToMerchant
            self.emails = emails
        }
    }
}
