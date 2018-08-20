import Vapor

extension BusinessOwner.ID {
    
    /// The type of identification for a business owner.
    public enum IDType: String, Hashable, CaseIterable, Content {
        
        /// `ASSOCIATION_NUMBER`
        case associationNumber = "ASSOCIATION_NUMBER"
        
        /// `BUSINESS_NUMBER`
        case businessNumber = "BUSINESS_NUMBER"
        
        /// `BUSINESS_REGISTRATION_NUMBER`
        case businessRegistrationNumber = "BUSINESS_REGISTRATION_NUMBER"
        
        /// `CNPJ`
        case cnpj = "CNPJ"
        
        /// `COMPANY_NUMBER`
        case companyNumber = "COMPANY_NUMBER"
        
        /// `COOPERATIVE_NUMBER`
        case cooperativeNumber = "COOPERATIVE_NUMBER"
        
        /// `CPF`
        case cpf = "CPF"
        
        /// `DRIVERS_LICENSE`
        case driversLicense = "DRIVERS_LICENSE"
        
        /// `EMPLOYMENT_IDENTIFICATION_NUMBER`
        case employmentIdentificationNumber = "EMPLOYMENT_IDENTIFICATION_NUMBER"
        
        /// `IMMIGRANT_ID`
        case immigrantID = "IMMIGRANT_ID"
        
        /// `INDIVIDUAL_TAX_IDENTIFICATION_NUMBER`
        case individualTaxIdentificationNumber = "INDIVIDUAL_TAX_IDENTIFICATION_NUMBER"
        
        /// `MEDICAL_INSURANCE_ID`
        case medicalInsuranceID = "MEDICAL_INSURANCE_ID"
        
        /// `NATIONAL_ID`
        case nationalID = "NATIONAL_ID"
        
        /// `PASSPORT_NUMBER`
        case passportNumber = "PASSPORT_NUMBER"
        
        /// `PENSION_FUND_ID`
        case pensionFundID = "PENSION_FUND_ID"
        
        /// `SOCIAL_INSURANCE_NUMBER`
        case socialInsuranceNumber = "SOCIAL_INSURANCE_NUMBER"
        
        /// `SOCIAL_SECURITY_NUMBER`
        case socialSecurityNumber = "SOCIAL_SECURITY_NUMBER"
        
        /// `VALUE_ADDED_TAX_ID`
        case valueAddedTaxID = "VALUE_ADDED_TAX_ID"
    }
}
