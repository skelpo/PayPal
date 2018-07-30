import Vapor

/// The tracking information for ordered and shipped merchandise.
public struct Tracking: Content, Equatable {
    
    /// The name of the carrier for the shipment of the transaction for this dispute.
    public var carrier: Carrier?
    
    /// This field capture the name of carrier in free form text for unavailable carriers from existing list.
    public var carrierOther: String?
    
    /// The URL to track the dispute-related transaction shipment.
    public var url: String?
    
    /// The number to track the dispute-related transaction shipment.
    public var number: String?
    
    /// Creates a new `Tracking` instance.
    ///
    ///     Tracking(carrier: .usps, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
    public init(carrier: Carrier?, other: String?, url: String?, number: String?) {
        self.carrier = carrier
        self.carrierOther = other
        self.url = url
        self.number = number
    }
    
    enum CodingKeys: String, CodingKey {
        case carrier = "carrier_name"
        case carrierOther = "carrier_name_other"
        case url = "tracking_url"
        case number = "tracking_number"
    }
}
