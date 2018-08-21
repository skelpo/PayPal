import Vapor

extension Business {
    
    /// The type of a company.
    public enum BusinessType: String, Hashable, CaseIterable, Content {
        
        /// `INDIVIDUAL`
        case individual = "INDIVIDUAL"
        
        /// `PROPRIETORSHIP`
        case proprietorship = "PROPRIETORSHIP"
        
        /// `PARTNERSHIP`
        case partnership = "PARTNERSHIP"
        
        /// `CORPORATION`
        case corporation = "CORPORATION"
        
        /// `NONPROFIT`
        case nonprofit = "NONPROFIT"
        
        /// `GOVERNMENT`
        case government = "GOVERNMENT"
        
        /// `PUBLIC_COMPANY`
        case publicCompany = "PUBLIC_COMPANY"
        
        /// `REGISTERED_COOPERATIVE`
        case registered = "REGISTERED_COOPERATIVE"
        
        /// `PROPRIETORY_COMPANY`
        case proprietory = "PROPRIETORY_COMPANY"
        
        /// `ASSOCIATION`
        case association = "ASSOCIATION"
        
        /// `PRIVATE_CORPORATION`
        case privateCorporation = "PRIVATE_CORPORATION"
        
        /// `LIMITED_PARTNERSHIP`
        case limitedPartnership = "LIMITED_PARTNERSHIP"
        
        /// `LIMITED_LIABILITY_PROPRIETORS`
        case limitedLiabilityProprietors = "LIMITED_LIABILITY_PROPRIETORS"
        
        /// `LIMITED_LIABILITY_PRIVATE_CORPORATION`
        case limitedLiabilityPrivateCorporation = "LIMITED_LIABILITY_PRIVATE_CORPORATION"
        
        /// `LIMITED_LIABILITY_PARTNERSHIP`
        case limitedLiabilityPartnership = "LIMITED_LIABILITY_PARTNERSHIP"
        
        /// `PUBLIC_CORPORATION`
        case publicCorporation = "PUBLIC_CORPORATION"
        
        /// `OTHER_CORPORATE_BODY`
        case otherCorporate = "OTHER_CORPORATE_BODY"
    }
}
