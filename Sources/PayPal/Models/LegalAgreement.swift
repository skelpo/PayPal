import Vapor

public struct LegalAgreement {}

extension LegalAgreement {
    
    /// The type of legal agreement between a merchant and partner.
    public enum AgreementType: String, Hashable, CaseIterable, Content {
        
        /// `USER_AGREEMENT`
        case userAgreement = "USER_AGREEMENT"
        
        /// `FINANCIAL_BINDING_AUTHORITY`
        case financialAuthority = "FINANCIAL_BINDING_AUTHORITY"
    }
}
