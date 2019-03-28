import PayPal

/// The detailed breakdown of a captured payment.
public struct SellerReceivableBreakdown: Codable {
    
    /// The amount for this captured payment.
    public let gross: CurrencyCodeAmount?
    
    /// The applicable fee for this captured payment.
    public let fee: CurrencyCodeAmount?
    
    /// The net amount that the payee receives for this captured payment in their PayPal account.
    /// The net amount is computed as `gross_amount` minus the `paypal_fee` minus the `platform_fees`.
    public let net: CurrencyCodeAmount?
    
    /// The net amount that is credited to the payee's PayPal account.
    /// Returned only when the currency of the captured payment is different from the currency of the PayPal account
    /// where the payee wants to credit the funds. The amount is computed as `net_amount` times `exchange_rate`.
    public let receivable: CurrencyCodeAmount?
    
    /// The exchange rate that determines the amount that is credited to the payee's PayPal account.
    /// Returned when the currency of the captured payment is different from the currency of the PayPal account
    /// where the payee wants to credit the funds.
    public let exchangeRate: ExchangeRate?
    
    /// An array of platform or partner fees, commissions, or brokerage fees that associated with the captured payment.
    public let fees: [PlatformFee]?
    
    /// Creates a new `SellerReceivableBreakdown` instance.
    ///
    /// - Parameters:
    ///   - gross: The amount for this captured payment.
    ///   - fee: The applicable fee for this captured payment.
    ///   - net: The net amount that the payee receives for this captured payment in their PayPal account.
    ///   - receivable: The net amount that is credited to the payee's PayPal account.
    ///   - exchangeRate: The exchange rate that determines the amount that is credited to the payee's PayPal account.
    ///   - fees: Platform or partner fees, commissions, or brokerage fees that associated with a captured payment.
    public init(
        gross: CurrencyCodeAmount?,
        fee: CurrencyCodeAmount?,
        net: CurrencyCodeAmount?,
        receivable: CurrencyCodeAmount?,
        exchangeRate: ExchangeRate?,
        fees: [PlatformFee]?
    ) {
        self.gross = gross
        self.fee = fee
        self.net = net
        self.receivable = receivable
        self.exchangeRate = exchangeRate
        self.fees = fees
    }
    
    enum CodingKeys: String, CodingKey {
        case gross = "gross_amount"
        case fee = "paypal_fee"
        case net = "net_amount"
        case receivable = "receivable_amount"
        case exchangeRate = "exchange_rate"
        case fees = "platform_fees"
    }
}
