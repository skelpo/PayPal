import Vapor

extension Business {
    
    /// The sub-type of a company.
    public enum SubType: String, Hashable, CaseIterable, Content {
        
        /// `ASSO_TYPE_INCORPORATED`
        case assoIncorporated = "ASSO_TYPE_INCORPORATED"
        
        /// `ASSO_TYPE_NON_INCORPORATED`
        case assoNonIncorporated = "ASSO_TYPE_NON_INCORPORATED"
        
        /// `GOVT_TYPE_EMANATION`
        case govtEmanation = "GOVT_TYPE_EMANATION"
        
        /// `GOVT_TYPE_ENTITY`
        case govtEntity = "GOVT_TYPE_ENTITY"
        
        /// `GOVT_TYPE_ESTD_COMM`
        case govtEstdComm = "GOVT_TYPE_ESTD_COMM"
        
        /// `GOVT_TYPE_ESTD_FC`
        case govtEstdFc = "GOVT_TYPE_ESTD_FC"
        
        /// `GOVT_TYPE_ESTD_ST_TR`
        case govtEstdStTr = "GOVT_TYPE_ESTD_ST_TR"
        
        /// `UNSELECTED`
        case unselected = "UNSELECTED"
    }
}
