import Vapor

extension FinancialInstrument {
    
    /// Financial instrument types.
    public enum InstrumentType: String, Hashable, CaseIterable, Content {
        
        /// `BANK`.
        case bank = "BANK"
    }
}
