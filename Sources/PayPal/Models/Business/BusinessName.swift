import Vapor

extension Business {
    
    /// The name of a business object.
    public struct Name: Content, ValidationSetable, Equatable {
        
        /// The legal category of the business.
        public var type: NameType
        
        /// The name of the business.
        ///
        /// Maximum length: 300.
        public private(set) var name: String
        
        
        /// Creates a new `Business.Name` instance.
        ///
        ///     Business.Name(type: .legal, name: "Stuff and Nonesense Inc.")
        public init(type: NameType, name: String) {
            self.type = type
            self.name = name
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Business.Name> {
            var validations = SetterValidations(Name.self)
            
            validations.set(\.name) { name in
                guard name.count <= 300 else { throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`name` length must be 300 or less") }
            }
            
            return validations
        }
    }
}

extension Business.Name {
    
    /// The legal categories a business can have.
    public enum NameType: String, Hashable, CaseIterable, Content {
        
        /// `LEGAL`
        case legal = "LEGAL"
        
        /// `DOING_BUSINESS_AS`
        case doingBusiness = "DOING_BUSINESS_AS"
        
        /// `STOCK_TRADING_NAME`
        case stockTrading = "STOCK_TRADING_NAME"
    }
}
