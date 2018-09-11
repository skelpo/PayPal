import Vapor

public struct AccountPermission {}

extension AccountPermission {
    public enum Permission: String, Hashable, CaseIterable, Content {
        case directPayment = "DIRECT_PAYMENT"
        case expressCheckout = "EXPRESS_CHECKOUT"
        case recurringPayment = "RECURRING_PAYMENT"
        case extendedProProcessing = "EXTENDED_PRO_PROCESSING"
        case exceptionProcessing = "EXCEPTION_PROCESSING"
        case settlementConsolidation = "SETTLEMENT_CONSOLIDATION"
        case settlementReporting = "SETTLEMENT_REPORTING"
        case massPay = "MASS_PAY"
        case encryptedWebsitePayments = "ENCRYPTED_WEBSITE_PAYMENTS"
        case disputeResolution = "DISPUTE_RESOLUTION"
        case sharedRefund = "SHARED_REFUND"
        case sharedAuthorization = "SHARED_AUTHORIZATION"
        case viewBalance = "VIEW_BALANCE"
        case viewProfile = "VIEW_PROFILE"
        case editProfile = "EDIT_PROFILE"
    }
}
