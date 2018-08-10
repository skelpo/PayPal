import Vapor

extension Invoice {
    
    /// Information for people who are connected to the invoice and will receive a copy of it.
    public struct Participant: Content, ValidationSetable, Equatable {
        
        /// The email address of the person who receives a copy of the invoice.
        ///
        /// Maximum length: 260.
        public var email: String
        
        /// Creates a new `Invoice.Participant` instance.
        ///
        ///     Invoice.Participant(email: "participant@example.com")
        public init(email: String)throws {
            self.email = email
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Invoice.Participant> {
            var validations = SetterValidations(Participant.self)
            
            validations.set(\.email) { email in
                guard email.count <= 260 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`email` property must have a length between 0 and 260")
                }
            }
            
            return validations
        }
    }
}
