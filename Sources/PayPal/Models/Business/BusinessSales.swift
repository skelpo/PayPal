import Vapor

extension Business {
    
    /// The sales information for a business.
    public struct Sales: Content, Equatable {
        
        /// The average transaction price.
        public var price: MoneyRange<CurrencyAmount>?
        
        /// The average volume of monthly sales.
        public var volume: MoneyRange<CurrencyAmount>?
        
        /// An array of sales venues for the business.
        public var venues: [SalesVenue]?
        
        /// The primary URL of the business.
        ///
        /// Maximum length: 255.
        public var website: Failable<String?, NotNilValidate<Length255>>
        
        /// The percentage of revenue attributable to online sales.
        public var online: PercentRange?
        
        
        /// Creates a new `Business.Sales` instance.
        ///
        /// - Parameters:
        ///   - price: The average transaction price.
        ///   - volume: The average volume of monthly sales.
        ///   - venues: An array of sales venues for the business.
        ///   - website: The primary URL of the business.
        ///   - online: The percentage of revenue attributable to online sales.
        public init(
            price: MoneyRange<CurrencyAmount>?,
            volume: MoneyRange<CurrencyAmount>?,
            venues: [SalesVenue]?,
            website: Failable<String?, NotNilValidate<Length255>>,
            online: PercentRange?
        ) {
            self.price = price
            self.volume = volume
            self.venues = venues
            self.website = website
            self.online = online
        }
        
        enum CodingKeys: String, CodingKey {
            case website
            case price = "average_price"
            case volume = "average_monthly_volume"
            case venues = "sales_venues"
            case online = "revenue_from_online_sales"
        }
    }
}
