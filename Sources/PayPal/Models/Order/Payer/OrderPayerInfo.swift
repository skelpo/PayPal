import Vapor

extension Order.Payer {
    public struct Info: Content, Equatable {
        public let salutation: String?
        public let firstname: String?
        public let middlename: String?
        public let lastname: String?
        public let suffix: String?
        public let payer: String?
        public let shipping: Address?
        
        public var email: String?
        public var birthdate: String?
        public var tax: String?
        public var taxType: TaxType?
        public var country: String?
        public var billing: Address?
        
        public init(
            email: String?,
            birthdate: String?,
            tax: String?,
            taxType: TaxType?,
            country: String?,
            billing: Address?
        ) {
            self.salutation = nil
            self.firstname = nil
            self.middlename = nil
            self.lastname = nil
            self.suffix = nil
            self.payer = nil
            self.shipping = nil
            
            self.email = email
            self.birthdate = birthdate
            self.tax = tax
            self.taxType = taxType
            self.country = country
            self.billing = billing
        }
    }
}

extension Order.Payer {
    
    /// A payer's tax ID type.
    public enum TaxType: String, Hashable, CaseIterable, Content {
        
        /// BR CPF tax ID type.
        case cpf = "BR_CPF"
        
        /// BR CNPJ tax ID type.
        case cnpj = "BR_CNPJ"
    }
}
