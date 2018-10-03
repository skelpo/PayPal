import Vapor

extension Evidence {
    
    /// The type of evidence use in a dispute.
    public enum EvidenceType: String, Hashable, CaseIterable, Content {
        
        /// PROOF_OF_FULFILLMENT
        case proofOfFulfillment = "PROOF_OF_FULFILLMENT"
        
        /// PROOF_OF_REFUND
        case proofOfRefund = "PROOF_OF_REFUND"
        
        /// PROOF_OF_DELIVERY_SIGNATURE
        case proofOfDeliverySignature = "PROOF_OF_DELIVERY_SIGNATURE"
        
        /// PROOF_OF_RECEIPT_COPY
        case proofOfReceiptCopy = "PROOF_OF_RECEIPT_COPY"
        
        /// RETURN_POLICY
        case returnPolicy = "RETURN_POLICY"
        
        /// BILLING_AGREEMENT
        case billingAgreement = "BILLING_AGREEMENT"
        
        /// PROOF_OF_RESHIPMENT
        case proofOfReshipment = "PROOF_OF_RESHIPMENT"
        
        /// ITEM_DESCRIPTION
        case itemDescription = "ITEM_DESCRIPTION"
        
        /// POLICE_REPORT
        case policeReport = "POLICE_REPORT"
        
        /// AFFIDAVIT
        case affidavit = "AFFIDAVIT"
        
        /// PAID_WITH_OTHER_METHOD
        case paidWithOtherMethod = "PAID_WITH_OTHER_METHOD"
        
        /// COPY_OF_CONTRACT
        case copyOfContract = "COPY_OF_CONTRACT"
        
        /// TERMINAL_ATM_RECEIPT
        case terminalAtmReceipt = "TERMINAL_ATM_RECEIPT"
        
        /// PRICE_DIFFERENCE_REASON
        case priceDifferenceReason = "PRICE_DIFFERENCE_REASON"
        
        /// SOURCE_CONVERSION_RATE
        case sourceConversionRate = "SOURCE_CONVERSION_RATE"
        
        /// BANK_STATEMENT
        case bankStatement = "BANK_STATEMENT"
        
        /// CREDIT_DUE_REASON
        case creditDueReason = "CREDIT_DUE_REASON"
        
        /// REQUEST_CREDIT_RECEIPT
        case requestCreditReceipt = "REQUEST_CREDIT_RECEIPT"
        
        /// PROOF_OF_RETURN
        case proofOfReturn = "PROOF_OF_RETURN"
        
        /// CREATE
        case create = "CREATE"
        
        /// CHANGE_REASON
        case changeReason = "CHANGE_REASON"
        
        /// OTHER
        case other = "OTHER"
    }
}
