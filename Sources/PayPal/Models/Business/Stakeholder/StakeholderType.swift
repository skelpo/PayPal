import Vapor

extension Business.Stakeholder {
    public enum StakeholderType: String, Hashable, CaseIterable, Content {
        case chairman = "CHAIRMAN"
        case partner = "PARTNER"
        case partnerBusiness = "PARTNER_BUSINESS"
        case secretary = "SECRETARY"
        case treasurer = "TREASURER"
        case director = "DIRECTOR"
        case beneficialOwner = "BENEFICIAL_OWNER"
        case beneficialOwnerBusiness = "BENEFICIAL_OWNER_BUSINESS"
    }
}
