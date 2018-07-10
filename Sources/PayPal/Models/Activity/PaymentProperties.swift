import Vapor

public final class PaymentProperties: Content {
    public var creditDebitCode: CreditDebitCode?
    public var buyerNotes: String?
    public var orderID: String?
    public var billingAgreementID: String?
    public var externalSubType: ExternalSubType?
    public var invoiceNumber: String?
    
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
    
    public enum ExternalSubType: String, Hashable, CaseIterable, Content {
        case unknown = "UNKNOWN"
        case purchase = "PURCHASE"
        case merchandiseReturn = "MERCHANDISE_RETURN"
        case cashWithdrawl = "CASH_WITHDRAWAL"
        case cashDeposit = "CASH_DEPOSIT"
        case debitTransfer = "DEBIT_TRANSFER"
        case creditTransfer = "CREDIT_TRANSFER"
        case debitPayment = "DEBIT_PAYMENT"
        case creditPayment = "CREDIT_PAYMENT"
        case purchaseWithCashback = "PURCHASE_WITH_CASHBACK"
    }
}
