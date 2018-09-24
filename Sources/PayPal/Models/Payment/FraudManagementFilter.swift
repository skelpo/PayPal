import Vapor

/// The Fraud Management Filter (FMF) details that are applied to a payment that result in an accept, deny, or pending action.
public typealias FMF = FraudManagementFilter

/// The Fraud Management Filter (FMF) details that are applied to a payment that result in an accept, deny, or pending action.
public struct FraudManagementFilter: Content, Equatable {
    
    /// The filter type.
    public let type: FilterType
    
    /// The filter ID.
    public let id: ID
    
    /// The filter name.
    public let name: String?
    
    /// The filter description.
    public let description: String?
}

extension FraudManagementFilter {
    
    /// The filter type of the Fraud Management Filter.
    public enum FilterType: String, Hashable, CaseIterable, Content {
        
        /// The accept filter type.
        case accept = "ACCEPT"
        
        /// The pending filter type.
        case pending = "PENDING"
        
        /// The deny filter type.
        case deny = "DENY"
        
        /// The report filter type.
        case report = "REPORT"
    }
}

extension FraudManagementFilter {
    
    /// The ID of a Fraud Management Filter.
    public enum ID: String, Hashable, CaseIterable, Content {
        
        /// AVS no match.
        case avsNoMatch = "AVS_NO_MATCH"
        
        /// AVS partial match.
        case avsPartialMatch = "AVS_PARTIAL_MATCH"
        
        /// AVS unavailable or unsupported.
        case avsUnavailable = "AVS_UNAVAILABLE_OR_UNSUPPORTED"
        
        /// Card security code mismatch.
        case securityCodeMismatch = "CARD_SECURITY_CODE_MISMATCH"
        
        /// The maximum transaction amount.
        case maxAmount = "MAXIMUM_TRANSACTION_AMOUNT"
        
        /// Unconfirmed address.
        case unconfirmedAddress = "UNCONFIRMED_ADDRESS"
        
        /// Country monitor.
        case countryMonitor = "COUNTRY_MONITOR"
        
        /// Large order number.
        case largeOrderNumber = "LARGE_ORDER_NUMBER"
        
        /// Billing or shipping address mismatch.
        case addressMismatch = "BILLING_OR_SHIPPING_ADDRESS_MISMATCH"
        
        /// Risky zip code.
        case riskyZip = "RISKY_ZIP_CODE"
        
        /// Suspected freight forwarder check.
        case freightCheck = "SUSPECTED_FREIGHT_FORWARDER_CHECK"
        
        /// Total purchase price minimum.
        case purchaseMin = "TOTAL_PURCHASE_PRICE_MINIMUM"
        
        /// IP address velocity.
        case ipVelocity = "IP_ADDRESS_VELOCITY"
        
        /// Risky email address domain check.
        case riskyDomainCheck = "RISKY_EMAIL_ADDRESS_DOMAIN_CHECK"
        
        /// Risky bank identification number check.
        case riskyBankIDCheck = "RISKY_BANK_IDENTIFICATION_NUMBER_CHECK"
        
        /// Risky IP address range.
        case riskyIPRange = "RISKY_IP_ADDRESS_RANGE"
        
        /// PayPal fraud model.
        case fraudModel = "PAYPAL_FRAUD_MODEL"
    }
}
