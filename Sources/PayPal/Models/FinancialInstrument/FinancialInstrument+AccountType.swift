import Vapor

extension FinancialInstrument {
    
    /// Possible bank account types.
    public enum AccountType: String, Hashable, CaseIterable, Content {
        
        /// `SAVINGS`.
        case saving = "SAVINGS"
        
        /// `CHECKING`.
        case checking = "CHECKING"
    }
}
