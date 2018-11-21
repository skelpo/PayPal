import Vapor

/// A record of a payment, currency transfer, money conversion, requests for payment, or promise of payment.
public struct Activity: Content, Equatable {
    
    /// The PayPal-generated ID for the activity.
    public var id: String
    
    /// The date and time when the activity was created,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public var timeCreated: String
    
    /// The type of activity that the object represents.
    public var type: ActivityType
    
    /// The sub-type of the activity, if the head `type` supports it.
    public var subtype: SubType?
    
    /// The current status of the activity.
    public var status: Status?
    
    /// The transaction's counter-party. A single-party transaction does not have
    /// counter-party information. For example, a single-party transaction might
    /// be a currency transfer or a PayPal credit payment.
    public var counterparty: CounterParty?
    
    /// The PayPal fees that are associated with this activity, in money format.
    public var fee: CurrencyCodeAmount?
    
    /// The amount for this activity before fees are applied.
    public var gross: CurrencyCodeAmount?
    
    /// The amount for this activity after fees are applied.
    public var net: CurrencyCodeAmount?
    
    /// The partner fees, in money format.
    public var partnerFee: CurrencyCodeAmount?
    
    /// The extension properties.
    public var extensions: Extensions?
    
    /// Creates a new `Activity` instance.
    public init(
        id: String,
        timeCreated: String,
        type: ActivityType,
        subtype: SubType?,
        status: Status?,
        counterparty: CounterParty?,
        fee: CurrencyCodeAmount?,
        gross: CurrencyCodeAmount?,
        net: CurrencyCodeAmount?,
        partnerFee: CurrencyCodeAmount?,
        extensions: Extensions?
    ) {
        self.id = id
        self.timeCreated = timeCreated
        self.type = type
        self.subtype = subtype
        self.status = status
        self.counterparty = counterparty
        self.fee = fee
        self.gross = gross
        self.net = net
        self.partnerFee = partnerFee
        self.extensions = extensions
    }
    
    /// Compares two `Activity` objects, checking all the stored properties for equality.
    public static func == (lhs: Activity, rhs: Activity) -> Bool {
        return
            (lhs.id == rhs.id) &&
            (lhs.timeCreated == rhs.timeCreated) &&
            (lhs.type == rhs.type) &&
            (lhs.subtype == rhs.subtype) &&
            (lhs.status == rhs.status) &&
            (lhs.counterparty == rhs.counterparty) &&
            (lhs.fee == rhs.fee) &&
            (lhs.gross == rhs.gross) &&
            (lhs.net == rhs.net) &&
            (lhs.partnerFee == rhs.partnerFee) &&
            (lhs.extensions == rhs.extensions)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, subtype, status, counterparty, fee, gross, net, extensions
        case timeCreated = "time_created"
        case type = "activity_type"
        case partnerFee = "partner_fee"
    }
}
