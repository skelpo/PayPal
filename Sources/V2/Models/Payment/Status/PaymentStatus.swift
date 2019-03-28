/// The possible statuses for an authorized payment.
public enum PaymentStatus: String, Hashable, Codable, CaseIterable {
    /// The authorized payment is created. No captured payments have been made for this authorized payment.
    case created = "CREATED"
    
    /// The authorized payment has one or more captures against it.
    /// The sum of these captured payments is greater than the amount of the original authorized payment.
    case captured = "CAPTURED"
    
    /// PayPal cannot authorize funds for this authorized payment.
    case denied = "DENIED"
    
    /// The authorized payment has expired.
    case expired = "EXPIRED"
    
    /// A captured payment was made for the authorized payment for an amount that is less
    /// than the amount of the original authorized payment.
    case partiallyCaptured = "PARTIALLY_CAPTURED"
    
    /// The authorized payment was voided. No more captured payments can be made against this authorized payment.
    case voided = "VOIDED"
}

/// The reason why a captured payment status is `PENDING` or `DENIED`.
public enum PaymentStatusDetails: String, Hashable, Codable, CaseIterable {
    /// The payer initiated a dispute for this captured payment with PayPal.
    case buyerComplaint = "BUYER_COMPLAINT"
    
    /// The captured funds were reversed in response to the payer disputing this captured payment
    /// with the issuer of the financial instrument used to pay for this captured payment.
    case chargeback = "CHARGEBACK"
    
    /// The payer paid by an eCheck that has not yet cleared.
    case echeck = "ECHECK"
    
    /// Visit your online account. In your **Account Overview**, accept and deny this payment.
    case internationalWithdrawal = "INTERNATIONAL_WITHDRAWAL"
    
    /// No additional specific reason can be provided. For more information about this captured payment,
    /// visit your account online or contact PayPal.
    case other = "OTHER"
    
    /// The captured payment is pending manual review.
    case pendingReview = "PENDING_REVIEW"
    
    /// The payee has not yet set up appropriate receiving preferences for their account.
    /// For more information about how to accept or deny this payment, visit your account online.
    /// This reason is typically offered in scenarios such as when the currency of the captured payment
    /// is different from the primary holding currency of the payee.
    case waitingManualAction = "RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION"
    
    /// The captured funds were refunded.
    case refunded = "REFUNDED"
    
    /// The payer must send the funds for this captured payment. This code generally appears for manual EFTs.
    case awaitingFunding = "TRANSACTION_APPROVED_AWAITING_FUNDING"
    
    /// The payee does not have a PayPal account.
    case unilateral = "UNILATERAL"
    
    /// The payee's PayPal account is not verified.
    case verificationRequired = "VERIFICATION_REQUIRED"
}
