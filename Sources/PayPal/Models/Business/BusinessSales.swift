import Vapor

extension Business {
    
    /// The sales information for a business.
    public struct Sales: Content, Equatable {
        
        /// The average transaction price.
        public var price: MoneyRange<Amount>?
        
        /// The average volume of monthly sales.
        public var volume: MoneyRange<Amount>?
        
        /// An array of sales venues for the business.
        public var venues: [SalesVenue]?
        
        /// The primary URL of the business.
        ///
        /// Maximum length: 255.
        public var website: String?
        
        /// The percentage of revenue attributable to online sales.
        public var online: PercentRange?
        
        
        /// Creates a new `Business.Sales` instance.
        ///
        ///     Business.Sales(
        ///         price: MoneyRange("50"..."60", currency: .usd),
        ///         volume: MoneyRange("50"..."60", currency: .usd),
        ///         venues: [],
        ///         website: "https://finiansbooksteacoffeeetc.com",
        ///         online: PercentRange(0...1)
        ///     )
        public init(price: MoneyRange<Amount>?, volume: MoneyRange<Amount>?, venues: [SalesVenue]?, website: String?, online: PercentRange?)throws {
            self.price = price
            self.volume = volume
            self.venues = venues
            self.website = website
            self.online = online
        }
    }
}
