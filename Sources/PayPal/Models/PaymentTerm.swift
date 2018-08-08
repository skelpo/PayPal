import Vapor

public struct PaymentTerm {}

extension PaymentTerm {
    
    /// The term in which the invoice is due.
    public enum TermType: String, Hashable, CaseIterable, Content {
        
        /// `DUE_ON_RECEIPT`
        case dueOnReceipt = "DUE_ON_RECEIPT"
        
        /// `DUE_ON_DATE_SPECIFIED`
        case dueDate = "DUE_ON_DATE_SPECIFIED"
        
        /// `NET_10`
        case net10 = "NET_10"
        
        /// `NET_15`
        case net15 = "NET_15"
        
        /// `NET_30`
        case net30 = "NET_30"
        
        /// `NET_45`
        case net45 = "NET_45"
        
        /// `NET_60`
        case net60 = "NET_60"
        
        /// `NET_90`
        case net90 = "NET_90"
        
        /// `NO_DUE_DATE`
        case noDueDate = "NO_DUE_DATE"
    }
}
