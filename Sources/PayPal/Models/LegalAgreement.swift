import Vapor

/// A legal agreement between a maerchant and a partner.
public struct LegalAgreement {
    
    /// Indicates whether the merchant accepted the legal agreement.
    public var accepted: Bool
    
    /// The type of legal agreement between the merchant and partner.
    public var type: AgreementType
    
    
    /// Creates a new `LegalAgreement` instance.
    ///
    ///     LegalAgreement(accepted: false, type: .userAgreement)
    ///
    /// - Parameters:
    ///   - accepted: Indicates whether the merchant accepted the legal agreement.
    ///   - type: The type of legal agreement between the merchant and partner.
    public init(accepted: Bool, type: AgreementType) {
        self.accepted = accepted
        self.type = type
    }
}

extension LegalAgreement {
    
    /// The type of legal agreement between a merchant and partner.
    public enum AgreementType: String, Hashable, CaseIterable, Content {
        
        /// `USER_AGREEMENT`
        case userAgreement = "USER_AGREEMENT"
        
        /// `FINANCIAL_BINDING_AUTHORITY`
        case financialAuthority = "FINANCIAL_BINDING_AUTHORITY"
    }
}
