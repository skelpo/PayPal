import Vapor

public struct LegalAgreement {}

extension LegalAgreement {
    public enum AgreementType: String, Hashable, CaseIterable, Content {
        case userAgreement = "USER_AGREEMENT"
        case financialAuthority = "FINANCIAL_BINDING_AUTHORITY"
    }
}
