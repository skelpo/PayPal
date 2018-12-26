import Vapor

extension Product {
    
    /// The permissions that can be granted to a partner.
    public enum GrantedPermission: String, Hashable, CaseIterable, Content {
        
        /// `EXPRESS_CHECKOUT`
        case expressCheckout = "EXPRESS_CHECKOUT"
        
        /// `REFUND`
        case refund = "REFUND"
        
        /// `DIRECT_PAYMENT`
        case directPayment = "DIRECT_PAYMENT"
        
        /// `AUTH_CAPTURE`
        case authCapture = "AUTH_CAPTURE"
        
        /// `BUTTON_MANAGER`
        case buttonManager = "BUTTON_MANAGER"
        
        /// `ACCOUNT_BALANCE`
        case accountBalance = "ACCOUNT_BALANCE"
        
        /// `TRANSACTION_DETAILS`
        case transactionDetails = "TRANSACTION_DETAILS"
        
        /// `TRANSACTION_SEARCH`
        case transactionSearch = "TRANSACTION_SEARCH"
        
        /// `REFERENCE_TRANSACTION`
        case referenceTransaction = "REFERENCE_TRANSACTION"
        
        /// `RECURRING_PAYMENTS`
        case recurringPayments = "RECURRING_PAYMENTS"
        
        /// `BILLING_AGREEMENT`
        case billingAgreement = "BILLING_AGREEMENT"
        
        /// `MANAGE_PENDING_TRANSACTION_STATUS`
        case managePendingTransactionStatus = "MANAGE_PENDING_TRANSACTION_STATUS"
        
        /// `NON_REFERENCED_CREDIT`
        case nonReferencedCredit = "NON_REFERENCED_CREDIT"
        
        /// `MASS_PAY`
        case massPay = "MASS_PAY"
        
        /// `ENCRYPTED_WEBSITE_PAYMENTS`
        case encryptedWebsitePayments = "ENCRYPTED_WEBSITE_PAYMENTS"
        
        /// `SETTLEMENT_CONSOLIDATION`
        case settlementConsolidation = "SETTLEMENT_CONSOLIDATION"
        
        /// `SETTLEMENT_REPORTING`
        case settlementReporting = "SETTLEMENT_REPORTING"
        
        /// `MOBILE_CHECKOUT`
        case mobileCheckout = "MOBILE_CHECKOUT"
        
        /// `AIR_TRAVEL`
        case airTravel = "AIR_TRAVEL"
        
        /// `INVOICING`
        case invoicing = "INVOICING"
        
        /// `RECURRING_PAYMENT_REPORT`
        case recurringPaymentReport = "RECURRING_PAYMENT_REPORT"
        
        /// `EXTENDED_PRO_PROCESSING_REPORT`
        case extendedProProcessingReport = "EXTENDED_PRO_PROCESSING_REPORT"
        
        /// `EXCEPTION_PROCESSING_REPORT`
        case exceptionProcessingReport = "EXCEPTION_PROCESSING_REPORT"
        
        /// `TRANSACTION_DETAIL_REPORT`
        case transactionDetailReport = "TRANSACTION_DETAIL_REPORT"
        
        /// `ACCOUNT_MANAGEMENT_PERMISSION`
        case accountManagementPermission = "ACCOUNT_MANAGEMENT_PERMISSION"
        
        /// `ACCESS_BASIC_PERSONAL_DATA`
        case accessBasicPersonalData = "ACCESS_BASIC_PERSONAL_DATA"
        
        /// `ACCESS_ADVANCED_PERSONAL_DATA`
        case accessAdvancedPersonalData = "ACCESS_ADVANCED_PERSONAL_DATA"
    }
}
