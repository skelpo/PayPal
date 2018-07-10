import Vapor

/// A record of a payment, currency transfer, money conversion, requests for payment, or promise of payment.
public final class Activity: Content {
    
    /// The PayPal-generated ID for the activity.
    public var id: String
    
    /// The date and time when the activity was created,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public var timeCreated: String
    
    /// The type of activity that the object represents.
    public var type: ActivityType
    
    /// The sub-type of the activity, if the head `type` supports it.
    public var subType: ActivitySubType?
    
    /// The current status of the activity.
    public var status: ActivityStatus?
    
    /// The transaction's counter-party. A single-party transaction does not have
    /// counter-party information. For example, a single-party transaction might
    /// be a currency transfer or a PayPal credit payment.
    public var counterparty: CounterParty?
    
    /// The PayPal fees that are associated with this activity, in money format.
    public var fee: Money?
    
    /// The amount for this activity before fees are applied.
    public var gross: Money?
    
    /// The amount for this activity after fees are applied.
    public var net: Money?
    
    /// The partner fees, in money format.
    public var partnerFee: Money?
    
    /// The extension properties.
    public var extensions: Extensions
    
    /// Creates a new `Activity` instance.
    public init(
        id: String,
        timeCreated: String,
        type: ActivityType,
        subType: ActivitySubType?,
        status: ActivityStatus?,
        counterparty: CounterParty?,
        fee: Money?,
        gross: Money?,
        net: Money?,
        partnerFee: Money?,
        extensions: Extensions
    ) {
        self.id = id
        self.timeCreated = timeCreated
        self.type = type
        self.subType = subType
        self.status = status
        self.counterparty = counterparty
        self.fee = fee
        self.gross = gross
        self.net = net
        self.partnerFee = partnerFee
        self.extensions = extensions
    }
}
