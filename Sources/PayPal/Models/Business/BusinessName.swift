import Vapor

extension Business {
    
    /// The name of a business object.
    public struct Name {
        
        /// The legal category of the business.
        public var type: NameType
        
        /// The name of the business.
        public var name: String
        
        
        /// Creates a new `Business.Name` instance.
        ///
        ///     Business.Name(type: .legal, name: "Stuff and Nonesense Inc.")
        public init(type: NameType, name: String) {
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
