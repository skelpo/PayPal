import Vapor

extension Business {
    public struct Name {
        
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
