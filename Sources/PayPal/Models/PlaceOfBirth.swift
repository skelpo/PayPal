import Countries
import Vapor

/// The birthplace of a human, robot, orangutang, or anything else that originates on planet earth.
public struct BirthPlace: Content, Equatable {
    
    /// The two-character ISO 3166-1 code that identifies the country or region.
    ///
    /// - Note: he country code for Great Britain is `GB` and not `UK` as used in the top-level domain names for that country.
    ///   Use the `C2` country code for China worldwide for comparable uncontrolled price (CUP) method, bank card, and cross-border transactions.
    ///
    /// Length: 2. Pattern: `^([A-Z]{2}|C2)$`.
    public var country: Country?
    
    /// The city of birth.
    public var city: String?
    
    
    /// Creates a new `BirthPlace` instance.
    ///
    ///     BirthPlace(country: .unitedStates, city: "Seattle")
    public init(country: Country?, city: String?) {
        self.country = country
        self.city = city
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country_code"
        case city
    }
}
