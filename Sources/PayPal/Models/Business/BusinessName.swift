import Vapor

extension Business {
    
    /// The name of a business, such as legal name or stock trading name.
    public struct Name: Content, Equatable {
        
        /// The legal category of the business.
        public var type: NameType
        
        /// The name of the business.
        ///
        /// Maximum length: 300.
        public var name: Failable<String, Length300>
        
        
        /// Creates a new `Business.Name` instance.
        ///
        /// - Parameters:
        ///   - type: The legal category of the business.
        ///   - name: The name of the business.
        public init(type: NameType, name: Failable<String, Length300>) {
            self.type = type
            self.name = name
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
