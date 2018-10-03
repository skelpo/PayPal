import Vapor

/// Additional information about a payment activity.
public struct PaymentProperties: Content, Equatable {
    
    /// The direction of the money transfer for the transaction.
    public var creditDebitCode: CreditDebitCode?
    
    /// The sender message for the transaction.
    public var buyerNotes: String?
    
    /// The ID of the order.
    public var orderID: String?
    
    /// The ID of the billing agreement.
    public var billingAgreementID: String?
    
    /// The type of monitary transaction that occured for the transaction.
    public var externalSubType: ExternalSubType?
    
    /// The merchant ID for the transaction.
    public var invoiceNumber: String?
    
    /// Creates a new `PaymentProperties` instance.
    public init(
        creditDebitCode: CreditDebitCode?,
        buyerNotes: String?,
        orderID: String?,
        billingAgreementID: String?,
        externalSubType: ExternalSubType?,
        invoiceNumber: String?
    ) {
        self.creditDebitCode = creditDebitCode
        self.buyerNotes = buyerNotes
        self.orderID = orderID
        self.billingAgreementID = billingAgreementID
        self.externalSubType = externalSubType
        self.invoiceNumber = invoiceNumber
    }
    
    /// Compares two `PaymentProperties` objects, checking that the `creditDebitCode`, `buyerNotes`,
    /// `billingAgreementID`, `externalSubType`, and `invoiceNumber` properties are the same
    public static func == (lhs: PaymentProperties, rhs: PaymentProperties) -> Bool {
        return
            (lhs.creditDebitCode == rhs.creditDebitCode) &&
            (lhs.buyerNotes == rhs.buyerNotes) &&
            (lhs.orderID == rhs.orderID) &&
            (lhs.billingAgreementID == rhs.billingAgreementID) &&
            (lhs.externalSubType == rhs.externalSubType) &&
            (lhs.invoiceNumber == rhs.invoiceNumber)
    }
    
    /// Defines what monitary transaction occured for a transaction.
    public enum ExternalSubType: String, Hashable, CaseIterable, Content {
        
        ///
        case unknown = "UNKNOWN"
        
        ///
        case purchase = "PURCHASE"
        
        ///
        case merchandiseReturn = "MERCHANDISE_RETURN"
        
        ///
        case cashWithdrawl = "CASH_WITHDRAWAL"
        
        ///
        case cashDeposit = "CASH_DEPOSIT"
        
        ///
        case debitTransfer = "DEBIT_TRANSFER"
        
        ///
        case creditTransfer = "CREDIT_TRANSFER"
        
        ///
        case debitPayment = "DEBIT_PAYMENT"
        
        ///
        case creditPayment = "CREDIT_PAYMENT"
        
        ///
        case purchaseWithCashback = "PURCHASE_WITH_CASHBACK"
    }
    
    enum CodingKeys: String, CodingKey {
        case creditDebitCode = "credit_debit_code"
        case buyerNotes = "buyer_notes"
        case orderID = "order_id"
        case billingAgreementID = "billing_agreement_id"
        case externalSubType = "external_sub_type"
        case invoiceNumber = "invoice_number"
    }
}
