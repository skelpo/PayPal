import Vapor

extension Invoice {
    
    /// Information for people who are connected to the invoice and will receive a copy of it.
    public struct Participant: Content, Equatable {
        
        /// The email address of the person who receives a copy of the invoice.
        ///
        /// Maximum length: 260.
        public var email: String
    }
}
