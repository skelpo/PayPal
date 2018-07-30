import Vapor

public struct Tracking: Content, Equatable {
    public var carrier: Carrier?
    public var carrierOther: String?
    public var url: String?
    public var number: String?
    
    public init(carrier: Carrier?, other: String?, url: String?, number: String?) {
        self.carrier = carrier
        self.carrierOther = other
        self.url = url
        self.number = number
    }
}
