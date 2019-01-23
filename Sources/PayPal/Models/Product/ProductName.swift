import Vapor

extension Product {
    
    /// The possible names of a partner product.
    public enum Name: String, Hashable, CaseIterable, Content {
        
        /// `EXPRESS_CHECKOUT`
        case expressCheckout = "EXPRESS_CHECKOUT"
        
        /// `WEBSITE_PAYMENTS_STANDARD`
        case websitePaymentsStandard = "WEBSITE_PAYMENTS_STANDARD"
        
        /// `MASS_PAYMENT`
        case massPayment = "MASS_PAYMENT"
        
        /// `EMAIL_PAYMENTS`
        case emailPayments = "EMAIL_PAYMENTS"
        
        /// `EBAY_CHECKOUT`
        case ebayCheckout = "EBAY_CHECKOUT"
        
        /// `PAYFLOW_LINK`
        case payflowLink = "PAYFLOW_LINK"
        
        /// `PAYFLOW_PRO`
        case payflowPro = "PAYFLOW_PRO"
        
        /// `WEBSITE_PAYMENTS_PRO_3_0`
        case websitePaymentsPro30 = "WEBSITE_PAYMENTS_PRO_3_0"
        
        /// `WEBSITE_PAYMENTS_PRO_2_0`
        case websitePaymentsPro20 = "WEBSITE_PAYMENTS_PRO_2_0"
        
        /// `VIRTUAL_TERMINAL`
        case virtualTreminal = "VIRTUAL_TERMINAL"
        
        /// `HOSTED_SOLE_SOLUTION`
        case hostedSoleSolution = "HOSTED_SOLE_SOLUTION"
        
        /// `BILL_ME_LATER`
        case billMeLater = "BILL_ME_LATER"
        
        /// `MOBILE_EXPRESS_CHECKOUT`
        case mobileExpressCheckout = "MOBILE_EXPRESS_CHECKOUT"
        
        /// `PAYPAL_HERE`
        case paypalHere = "PAYPAL_HERE"
        
        /// `MOBILE_IN_STORE`
        case mobileInStore = "MOBILE_IN_STORE"
        
        /// `PAYPAL_STANDARD`
        case paypalStandard = "PAYPAL_STANDARD"
        
        /// `MOBILE_PAYPAL_STANDARD`
        case mobilePaypalStandard = "MOBILE_PAYPAL_STANDARD"
        
        /// `MOBILE_PAYMENT_ACCEPTANCE`
        case mobilePaymentAcceptance = "MOBILE_PAYMENT_ACCEPTANCE"
        
        /// `PAYPAL_ADVANCED`
        case paypalAdvanced = "PAYPAL_ADVANCED"
        
        /// `PAYPAL_PRO`
        case paypalPro = "PAYPAL_PRO"
        
        /// `ENHANCED_RECURRING_PAYMENTS`
        case enhancedRecurringPayments = "ENHANCED_RECURRING_PAYMENTS"
    }
}
