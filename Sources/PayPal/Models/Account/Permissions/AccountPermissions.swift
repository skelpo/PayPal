import Vapor

/// Permissions that can be assigned to an account.
public struct AccountPermission: Content, Equatable {
    
    /// The third-party ID for the account.
    public var thirdParty: String?
    
    /// The permission to assign to the account.
    ///
    /// - Note: The `SETTLEMENT_CONSOLIDATION` permissions is not applicable to all partners.
    public var permissions: [Permission]?
    
    /// Creates a new `AccountPermission` instance.
    ///
    ///     AccountPermission(thiredParty: "FDF4D16C-11C0-4792-A956-6A3A9D8B49C2", permissions: [.directPayment])
    ///
    /// - Parameters:
    ///   - thirdParty: The third-party ID for the account.
    ///   - permissions: The permission to assign to the account.
    public init(thirdParty: String?, permissions: [Permission]?) {
        self.thirdParty = thirdParty
        self.permissions = permissions
    }
}

extension AccountPermission {
    
    /// Permission that can be assigned to an account.
    public enum Permission: String, Hashable, CaseIterable, Content {
        
        /// Processes direct credit card transactions for the managed account by using PayPal Payments Pro,
        /// if the account is enabled for it. Provides access to the `DoDirectPayment` API.
        case directPayment = "DIRECT_PAYMENT"
        
        /// Processes Express Checkout transactions.
        ///
        /// Provides access to these APIs:
        /// - `SetExpressCheckout`
        /// - `GetExpressCheckoutDetails`
        /// - `DoExpressCheckoutPayment`
        /// - `GetPalDetails`
        ///
        /// If you are subscribed to any of the following reports, this permission consolidates the reporting information
        /// from the managed account into your reports:
        /// - Preapproved Payment Agreement Report
        /// - Subscription Agreement Report
        /// - Order Report
        case expressCheckout = "EXPRESS_CHECKOUT"
        
        /// Processes recurring payments for the managed account.
        ///
        /// Provides access to these APIs:
        /// - `BillAgreementUpdate`
        /// - `BillUser`
        /// - `SetCustomerBillingAgreement`
        /// - `GetBillingAgreementCustomerDetails`
        /// - `CreateBillingAgreement`
        /// - `DoReferenceTransaction`
        case recurringPayment = "RECURRING_PAYMENT"
        
        /// Completes back-end processing functions for the managed account.
        ///
        /// Provides access to these APIs:
        /// - `DoCapture`
        /// - `DoAuthorization`
        /// - `DoReauthorization`
        /// - `DoVoid`
        ///
        /// This permission also allows you to use PayPal’s batch processing, if you are enabled for it,
        /// to perform batch captures on behalf of the managed account.
        case extendedProProcessing = "EXTENDED_PRO_PROCESSING"
        
        /// Completes certain customer service functions for the managed account. Provides access to these APIs:
        /// - `RefundTransaction`
        /// - `TransactionSearch`
        /// - `GetTransactionDetails`
        ///
        /// If you are subscribed to any of the following reports, this permission consolidates the reporting information
        /// from the managed account into your reports:
        /// - Transaction Detail Report
        /// - Case Report
        ///
        /// This permission also allows you to use PayPal’s batch processing, if you are enabled for it,
        /// to complete batch captures on behalf of the managed account.
        case exceptionProcessing = "EXCEPTION_PROCESSING"
        
        /// Consolidates funds from the managed account into your account on a daily basis. With this permission set,
        /// PayPal sweeps all funds from the managed account into your account on a daily basis. If the managed account balance is negative,
        /// PayPal deducts the negative balance from your account to true-up the account’s balance back to zero.
        ///
        /// If you are subscribed to any of the following reports, this permission consolidates the reporting information
        /// from the managed account into your reports:
        /// - Transaction Detail Report
        /// - Settlement Report
        case settlementConsolidation = "SETTLEMENT_CONSOLIDATION"
        
        /// Consolidates reporting information from the managed account into your account.
        ///
        /// If you are subscribed to any of the following reports, this permission consolidates the reporting information
        /// from the managed account into your reports:
        /// - Transaction Detail Report
        /// - Settlement Report
        case settlementReporting = "SETTLEMENT_REPORTING"
        
        /// Makes payments from the managed account using PayPal’s `MassPay` API.
        case massPay = "MASS_PAY"
        
        /// Encrypts standard PayPal payments buttons on behalf of the managed account using PayPal’s Encrypted Website Payments feature.
        case encryptedWebsitePayments = "ENCRYPTED_WEBSITE_PAYMENTS"
        
        /// Responds to disputes on behalf of the managed account. With this permission set,
        /// disputes opened against the campaign appear in the Resolution Center for your account.
        case disputeResolution = "DISPUTE_RESOLUTION"
        
        /// Processes refunds against your own account for transactions originally accepted by the managed account.
        case sharedRefund = "SHARED_REFUND"
        
        /// Captures transactions using your own account against authorizations originally obtained by the managed account.
        case sharedAuthorization = "SHARED_AUTHORIZATION"
        
        /// Retrieves the managed account’s PayPal balance. Provides access to the following `GetBalance` API.
        case viewBalance = "VIEW_BALANCE"
        
        /// Shows the managed account’s profile.
        case viewProfile = "VIEW_PROFILE"
        
        /// Edits the managed account’s profile.
        case editProfile = "EDIT_PROFILE"
    }
}
