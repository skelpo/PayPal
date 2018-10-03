import Vapor

extension Activity {
    
    /// The sub-type of an activity's type. Only `ActivityType.payment` and `.billingAgreement`
    /// cases can have a sub-type.
    public enum SubType: String, Hashable, CaseIterable, Content {
        
        ///
        case all = "ALL"
        
        // MARK: - Payment
        
        /// Movement of funds between accounts by PayPal to resolve a chargeback or dispute.
        case adjustment = "ADJUSTMENT"
        
        /// Authorized hold of funds by PayPal on a customer’s account.
        case authorization = "AUTHORIZATION"
        
        /// PayPal-funded reward or award to a customer's account.
        case bonus = "BONUS"
        
        /// Addition or removal of funds by PayPal.
        case correction = "CORRECTION"
        
        /// Conversion of funds from one currency to another.
        case currencyTransfer = "CURRENCY_TRANSFER"
        
        /// Payment is under review by PayPal.
        case hold = "HOLD"
        
        /// Transfer of funds from a main PayPal balance account to another PayPal balance account.
        case holdingBalanceTransfer = "HOLDING_BALANCE_TRANSFER"
        
        /// PayPal credit offered to the seller.
        case loan = "LOAN"
        
        /// Transfer of funds from a customer's PayPal account to another funding instrument.
        case moneyTransfer = "MONEY_TRANSFER"
        
        /// Payment of funds from one entity to another.
        case payment = "PAYMENT"
        
        /// Customer repayment of PayPal-provided credit.
        case paypalCreditPayment = "PAYPAL_CREDIT_PAYMENT"
        
        /// Receiver-returned payment to the sender, sender-canceled payment, or unclaimed payment within 30 days.
        case refund = "REFUND"
        
        /// PayPal-initiated return of funds to sender.
        case reversal = "REVERSAL"
        
        /// Customer-placed authorization or order that no longer applies.
        case void = "VOID"
        
        
        // MARK: - Billing Agreement
        
        /// Billing agreement is cancelled.
        case subscriptionCancellation = "SUBSCRIPTION_CANCELLATION"
        
        /// Billing agreement is complete.
        case subscriptionCompletion = "SUBSCRIPTION_COMPLETION"
        
        /// Billing agreement is created.
        case subscriptionCreation = "SUBSCRIPTION_CREATION"
        
        /// Billing agreement is modified.
        case subscriptionModification = "SUBSCRIPTION_MODIFICATION"
        
        /// The `ActivityType` case that the `SubType` case is valid for.
        public var parentType: ActivityType? {
            switch self {
            case
            .adjustment, .authorization, .bonus, .correction, .currencyTransfer, .hold, .holdingBalanceTransfer,
            .loan, .moneyTransfer, .payment, .paypalCreditPayment, .refund, .reversal, .void:
                return .payment
            case .subscriptionCancellation, .subscriptionCompletion, .subscriptionCreation, .subscriptionModification:
                return .billingAgreement
            case .all: return nil
            }
        }
    }
}
