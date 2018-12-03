import Vapor

extension RelatedResource {
    
    /// The details of a capture transaction.
    public struct Capture: Content, ValidationSetable, Equatable {
        
        /// The ID of the capture transaction.
        public let id: String?
        
        /// The state of the capture.
        public let state: State?
        
        /// The reason code that describes why the transaction state is pending or reversed.
        public let reason: Reason?
        
        /// The ID of the payment on which this transaction is based.
        public let parent: String?
        
        /// The date and time of the capture, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public let created: String?
        
        /// The date and time when the resource was last updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6)
        public let updated: String?
        
        /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
        public let links: [LinkDescription]?
        
        
        /// The amount to capture. If the amount matches the originally authorized amount,
        /// the state of the authorization changes to `captured`. Otherwise, the state changes to `partially_captured`.
        public var amount: DetailedAmount?
        
        /// Indicates whether to release all remaining held funds.
        public var isFinal: Bool?
        
        /// The invoice number to track this payment.
        ///
        /// This property can be set using the `Capture.set(_:)` method. This
        /// method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var invoice: String?
        
        /// The currency and amount of the transaction fee for this payment.
        public var transaction: CurrencyAmount?
        
        /// A free-form field that clients can use to send a note to the payer.
        ///
        /// This property can be set using the `Capture.set(_:)` method. This
        /// method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 255.
        public private(set) var payerNote: String?
        
        
        /// Creates a new `RelatedResource.Capture` struct.
        ///
        /// - Parameters:
        ///   - amount: The amount to capture.
        ///   - isFinal: Indicates whether to release all remaining held funds.
        ///   - invoice: The invoice number to track this payment.
        ///   - transaction: The currency and amount of the transaction fee for this payment.
        ///   - payerNote: A free-form field that clients can use to send a note to the payer.
        public init(amount: DetailedAmount?, isFinal: Bool?, invoice: String?, transaction: CurrencyAmount?, payerNote: String?)throws {
            self.id = nil
            self.state = nil
            self.reason = nil
            self.parent = nil
            self.created = nil
            self.updated = nil
            self.links = nil
            
            self.amount = amount
            self.isFinal = isFinal
            self.invoice = invoice
            self.transaction = transaction
            self.payerNote = payerNote
            
            try self.set(\.invoice <~ invoice)
            try self.set(\.payerNote <~ payerNote)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(String.self, forKey: .id)
            self.state = try container.decodeIfPresent(State.self, forKey: .state)
            self.reason = try container.decodeIfPresent(Reason.self, forKey: .reason)
            self.parent = try container.decodeIfPresent(String.self, forKey: .parent)
            self.created = try container.decodeIfPresent(String.self, forKey: .created)
            self.updated = try container.decodeIfPresent(String.self, forKey: .updated)
            self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
            self.amount = try container.decodeIfPresent(DetailedAmount.self, forKey: .amount)
            self.isFinal = try container.decodeIfPresent(Bool.self, forKey: .isFinal)
            self.invoice = try container.decodeIfPresent(String.self, forKey: .invoice)
            self.transaction = try container.decodeIfPresent(CurrencyAmount.self, forKey: .transaction)
            self.payerNote = try container.decodeIfPresent(String.self, forKey: .payerNote)
            
            try self.set(\.invoice <~ invoice)
            try self.set(\.payerNote <~ payerNote)
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<RelatedResource.Capture> {
            var validations = SetterValidations(RelatedResource.Capture.self)
            
            validations.set(\.invoice) { invoice in
                guard invoice?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`invoice` value must have a length of 127 or less")
                }
            }
            validations.set(\.payerNote) { note in
                guard note?.count ?? 0 <= 255 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`payerNote` value lnegth must be 255 or less")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case id, amount, state, links
            case reason = "reason_code"
            case parent = "parent_payment"
            case created = "create_time"
            case updated = "update_time"
            case isFinal = "is_final_capture"
            case invoice = "invoice_number"
            case transaction = "transaction_fee"
            case payerNote = "note_to_payer"
        }
    }
}

extension RelatedResource.Capture {
    
    /// The state of a capture
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// The capture is pending.
        case pending
        
        /// The capture has successfully completed.
        case completed
        
        /// The capture was fully refunded.
        case refunded
        
        /// The capture was partially refunded.
        case partiallyRefunded = "partially_refunded"
        
        /// PayPal has declined to process this transaction.
        case denied
    }
}

extension RelatedResource.Capture {
    
    /// The reason code that describes why a transaction state is pending or reversed. 
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// The transaction state is `pending` or `reversed` due to a chargeback.
        case chargeback = "CHARGEBACK"
        
        /// The transaction state is `pending` or `reversed` due to a guarantee.case
        case guarantee = "GUARANTEE"
        
        /// The transaction state is `pending` or `reversed` due to a customer complaint.
        case buyerComplaint = "BUYER_COMPLAINT"
        
        /// The transaction state is `pending` or `reversed` due to a REFUND.
        case refund = "REFUND"
        
        /// The transaction state is `pending` or `reversed` due to an unconfirmed shipping address.
        case unconfirmedAddress = "UNCONFIRMED_SHIPPING_ADDRESS"
        
        /// The transaction state is `pending` or `reversed` due to an e-check.
        case echeck = "ECHECK"
        
        /// The transaction state is `pending` or `reversed` due to an international withdrawal.
        case withdrawl = "INTERNATIONAL_WITHDRAWAL"
        
        /// The transaction state is `pending` or `reversed` due to a receiving preference that mandates manual action.
        case manualAction = "RECEIVING_PREFERENCE_MANDATES_MANUAL_ACTION"
        
        /// The transaction state is `pending` or `reversed` due to a payment review.
        case payment = "PAYMENT_REVIEW"
        
        /// The transaction state is `pending` or `reversed` due to a regulatory review.
        case regulatory = "REGULATORY_REVIEW"
        
        /// The transaction state is `pending` or `reversed` due to a unilaterial action.
        case unilateral = "UNILATERAL"
        
        /// The transaction state is `pending` or `reversed` because verification is required.
        case verification = "VERIFICATION_REQUIRED"
        
        /// The transaction state is `pending` or `reversed` because an approved transaction is awaiting funding.
        case awaitingFunding = "TRANSACTION_APPROVED_AWAITING_FUNDING"
    }
}
