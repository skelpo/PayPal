import Vapor

extension Business {
    public struct Sales: Content, Equatable {
        public var price: MoneyRange<Amount>?
        public var volume: MoneyRange<Amount>?
        public var venues: [SalesVenue]?
        public var website: String?
        public var online: PercentRange?
        
        public init(price: MoneyRange<Amount>?, volume: MoneyRange<Amount>?, venues: [SalesVenue]?, website: String?, online: PercentRange?)throws {
            self.price = price
            self.volume = volume
            self.venues = venues
            self.website = website
            self.online = online
        }
    }
}
