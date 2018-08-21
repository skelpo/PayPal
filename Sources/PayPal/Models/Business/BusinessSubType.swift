import Vapor

extension Business {
    
    /// The sub-type of a company.
    public enum SubType: String, Hashable, CaseIterable, Content {
        
        /// `ASSO_TYPE_INCORPORATED`
        case ASSO_TYPE_INCORPORATED = "ASSO_TYPE_INCORPORATED"
        
        /// `ASSO_TYPE_NON_INCORPORATED`
        case ASSO_TYPE_NON_INCORPORATED = "ASSO_TYPE_NON_INCORPORATED"
        
        /// `GOVT_TYPE_EMANATION`
        case GOVT_TYPE_EMANATION = "GOVT_TYPE_EMANATION"
        
        /// `GOVT_TYPE_ENTITY`
        case GOVT_TYPE_ENTITY = "GOVT_TYPE_ENTITY"
        
        /// `GOVT_TYPE_ESTD_COMM`
        case GOVT_TYPE_ESTD_COMM = "GOVT_TYPE_ESTD_COMM"
        
        /// `GOVT_TYPE_ESTD_FC`
        case GOVT_TYPE_ESTD_FC = "GOVT_TYPE_ESTD_FC"
        
        /// `GOVT_TYPE_ESTD_ST_TR`
        case GOVT_TYPE_ESTD_ST_TR = "GOVT_TYPE_ESTD_ST_TR"
        
        /// `UNSELECTED`
        case UNSELECTED = "UNSELECTED"
    }
}
