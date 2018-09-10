import Vapor

extension Business.Stakeholder {
    
    /// The type of stakeholder in a business.
    public enum StakeholderType: String, Hashable, CaseIterable, Content {
        
        /// `CHAIRMAN`
        case chairman = "CHAIRMAN"
        
        /// `PARTNER`
        case partner = "PARTNER"
        
        /// `PARTNER_BUSINESS`
        case partnerBusiness = "PARTNER_BUSINESS"
        
        /// `SECRETARY`
        case secretary = "SECRETARY"
        
        /// `TREASURER`
        case treasurer = "TREASURER"
        
        /// `DIRECTOR`
        case director = "DIRECTOR"
        
        /// `BENEFICIAL_OWNER`
        case beneficialOwner = "BENEFICIAL_OWNER"
        
        /// `BENEFICIAL_OWNER_BUSINESS`
        case beneficialOwnerBusiness = "BENEFICIAL_OWNER_BUSINESS"
    }
}
