import PayPal

/// Additional payment instructions for PayPal for Partner customers.
/// Enables features for partners and marketplaces, such as delayed disbursement and collection of a platform fee.
public struct PaymentInstruction: Codable {
    
    /// An array of various fees, commissions, tips, or donations.
    public var fees: [PlatformFee]?
    
    /// The funds that are held on behalf of the merchant.
    public var disbursement: Order.DisbursementMode?
    
    /// Creates a new `PaymentInstruction` instance.
    ///
    /// - Parameters:
    ///   - fees: An array of various fees, commissions, tips, or donations.
    ///   - disbursement: The funds that are held on behalf of the merchant. Defaults to `.instant`.
    public init(fees: [PlatformFee]?, disbursement: Order.DisbursementMode? = .instant) {
        self.fees = fees
        self.disbursement = disbursement
    }
    
    enum CodingKeys: String, CodingKey {
        case fees = "platform_fees"
        case disbursement = "disbursement_mode"
    }
}
