import Vapor

extension Invoice {
    
    /// The unit of measure for an invoiced item.
    public enum Measure: String, Hashable, CaseIterable, Content {
        
        /// `QUANTITY`
        case quantity = "QUANTITY"
        
        /// `HOURS`
        case hours = "HOURS"
        
        /// `AMOUNT`
        case amount = "AMOUNT"
    }
}
