import Vapor

extension Business {
    
    /// The sales information for a business.
    public struct Sales: Content, ValidationSetable, Equatable {
        
        /// The average transaction price.
        public var price: MoneyRange<Amount>?
        
        /// The average volume of monthly sales.
        public var volume: MoneyRange<Amount>?
        
        /// An array of sales venues for the business.
        public var venues: [SalesVenue]?
        
        /// The primary URL of the business.
        ///
        /// This property can be set using the `Sales.set(_:)` method. This method
        /// will validate the new value before assigning it to the property.
        ///
        /// Maximum length: 255.
        public private(set) var website: String?
        
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
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Business.Sales> {
            var validations = SetterValidations(Sales.self)
            
            validations.set(\.website) { website in
                guard let website = website else { return }
                guard website.count <= 255 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`website` value must have a length of 255 or less")
                }
            }
            
            return validations
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
