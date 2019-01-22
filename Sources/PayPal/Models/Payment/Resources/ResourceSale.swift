import Vapor

extension RelatedResource {
    
    /// A sale transaction that is related to a payment.
    public struct Sale: Content, Equatable {
        
        /// The ID of the sale transaction.
        public let id: String
        
        /// The ID of the transaction that corresponds to this sale transaction.
        public let purchaseID: String?
        
        /// The transaction payment mode. Supported only for PayPal payments.
        public let mode: PaymentMode?
        
        /// The state of the sale transaction.
        public let state: State
        
        /// A reason code that describes why the transaction state is pending or reversed. Supported only for PayPal payments.
        public let reason: Reason?
        
        /// The merchant protection level in effect for the transaction. Supported only for PayPal payments.
        public let protection: Protection?
        
        /// The merchant protection type in effect for the transaction. Returned only when `protection_eligibility` is
        /// `ELIGIBLE` or `PARTIALLY_ELIGIBLE`. Supported only for PayPal payments.
        public let protectionType: ProtectionType?
        
        /// The date and time when the PayPal eCheck transaction is expected to clear,
        /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let clearing: ISO8601Date?
        
        /// The recipient fund status. Returned only when the fund status is `held`.
        public let holdStatus: String?
        
        /// An array of reasons that PayPal holds the recipient fund. Set only if the payment hold status is `HELD`.
        public let holdReasons: [Payment.HoldReason]?
        
        /// The receipt ID, which is a payment ID number that is returned for guest users to identify the payment.
        ///
        /// Pattern: `^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}$`.
        public let receipt: String?
        
        /// The ID of the payment on which this transaction is based.
        public let parent: String
        
        /// The ID of the billing agreement. Used as reference to execute this transaction.
        public let billingAgreement: String?
        
        /// The date and time of the sale, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let created: ISO8601Date
        
        /// The date and time when the resource was last updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let updated: ISO8601Date?
        
        /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
        public let links: [LinkDescription]?
        
        
        /// The amount to collect.
        public var amount: DetailedAmount
        
        /// The currency and amount of the transaction fee.
        public var transaction: CurrencyAmount?
        
        /// The currency and amount of the net that the merchant receives for this transaction in their receivable currency.
        /// Returned only in cross-currency use cases where a merchant bills a buyer in a non-primary currency for that buyer.
        public var receivable: CurrencyAmount?
        
        /// The exchange rate for this transaction. Returned only in cross-currency use cases where a merchant bills
        /// a buyer in a non-primary currency for that buyer.
        public var exchangeRate: String?
        
        /// The Fraud Management Filter (FMF) details that are applied to the payment that result in an accept, deny, or pending action.
        /// Returned in a payment response only if the merchant has enabled FMF in the profile settings and one of the fraud filters was
        /// triggered based on those settings. For more information, see
        /// [Fraud Management Filters Summary](https://developer.paypal.com/docs/classic/fmf/integration-guide/FMFSummary/).
        public var fmf: FraudManagementFilter?
        
        /// The processor-provided response codes that describe the submitted payment. Supported only when the `payment_method` is `credit_card`.
        public var processor: ProcessorResponse?
        
        
        /// Creates a new `RelatedResource.Sale` instance.
        ///
        /// - Parameters:
        ///   - amount: The amount to collect.
        ///   - state: The state of the sale transaction.
        ///   - transaction: The currency and amount of the transaction fee.
        ///   - receivable: The currency and amount of the net that the merchant receives for this transaction in their receivable currency.
        ///   - exchangeRate: The exchange rate for this transaction.
        ///   - fmf: The Fraud Management Filter (FMF) details that are applied to the payment that result in an accept, deny, or pending action.
        ///   - processor: The processor-provided response codes that describe the submitted payment.
        ///   - parent: The ID of the payment on which this transaction is based.
        ///   - created: The date and time of the sale.
        public init(
            id: String,
            amount: DetailedAmount,
            state: State,
            transaction: CurrencyAmount? = nil,
            receivable: CurrencyAmount? = nil,
            exchangeRate: String? = nil,
            fmf: FraudManagementFilter? = nil,
            processor: ProcessorResponse? = nil,
            parent: String,
            created: Date = Date()
        ) {
            self.id = id
            self.purchaseID = nil
            self.mode = nil
            self.state = state
            self.reason = nil
            self.protection = nil
            self.protectionType = nil
            self.clearing = nil
            self.holdStatus = nil
            self.holdReasons = nil
            self.receipt = nil
            self.parent = parent
            self.billingAgreement = nil
            self.created = ISO8601Date(created)
            self.updated = nil
            self.links = nil
            self.amount = amount
            self.transaction = transaction
            self.receivable = receivable
            self.exchangeRate = exchangeRate
            self.fmf = fmf
            self.processor = processor
        }
        
        enum CodingKeys: String, CodingKey {
            case id, amount, state, links
            case purchaseID = "purchase_unit_reference_id"
            case mode = "payment_mode"
            case reason = "reason_code"
            case protection = "protection_eligibility"
            case protectionType = "protection_eligibility_type"
            case clearing = "clearing_time"
            case holdStatus = "payment_hold_status"
            case holdReasons = "payment_hold_reasons"
            case transaction = "transaction_fee"
            case receivable = "receivable_amount"
            case exchangeRate = "exchange_rate"
            case fmf = "fmf_details"
            case receipt = "receipt_id"
            case parent = "parent_payment"
            case processor = "processor_response"
            case billingAgreement = "billing_agreement_id"
            case created = "create_time"
            case updated = "update_time"
        }
    }
}

extension RelatedResource.Sale {
    
    /// The possible transaction payment modes.
    public enum PaymentMode: String, Hashable, CaseIterable, Content {
        
        /// `INSTANT_TRANSFER`.
        case instantTransfer = "INSTANT_TRANSFER"
        
        /// `MANUAL_BANK_TRANSFER`.
        case manualTransfer = "MANUAL_BANK_TRANSFER"
        
        /// `DELAYED_TRANSFER`.
        case delayedTransfer = "DELAYED_TRANSFER"
        
        /// `ECHECK`.
        case echeck = "ECHECK"
    }
}

extension RelatedResource.Sale {
    
    /// The state of a sale transaction.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// `completed`.
        case completed
        
        /// `partially_refunded`.
        case partiallyRefunded = "partially_refunded"
        
        /// `pending`.
        case pending
        
        /// `refunded`.
        case refunded
        
        /// `denied`.
        case denied
    }
}

extension RelatedResource.Sale {
    
    /// A reason code that describes why the transaction state is pending or reversed.
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// `CHARGEBACK`.
        case chargeback = "CHARGEBACK"
        
        /// `GUARANTEE`.
        case guarantee = "GUARANTEE"
        
        /// `BUYER_COMPLAINT`.
        case complaint = "BUYER_COMPLAINT"
        
        /// `REFUND`.
        case refund = "REFUND"
        
        /// `UNCONFIRMED_SHIPPING_ADDRESS`.
        case unconfirmedAddress = "UNCONFIRMED_SHIPPING_ADDRESS"
        
        /// `ECHECK`.
        case echeck = "ECHECK"
        
        /// `INTERNATIONAL_WITHDRAWAL`.
        case withdrawl = "INTERNATIONAL_WITHDRAWAL"
        
        /// `RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION`.
        case manualAction = "RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION"
        
        /// `PAYMENT_REVIEW`.
        case payment = "PAYMENT_REVIEW"
        
        /// `REGULATORY_REVIEW`.
        case regulatory = "REGULATORY_REVIEW"
        
        /// `UNILATERAL`.
        case unilateral = "UNILATERAL"
        
        /// `VERIFICATION_REQUIRED`.
        case verification = "VERIFICATION_REQUIRED"
        
        /// `TRANSACTION_APPROVED_AWAITING_FUNDING`.
        case awaitingFunding = "TRANSACTION_APPROVED_AWAITING_FUNDING"
    }
}
