import Countries
import PayPal
    
/// Address of the payer party in an order.
public struct Address: Codable {
    
    /// The first line of the address. For example, number or street. For example, `173 Drury Lane`.
    /// Required for data entry and compliance and risk checks. Must contain the full address.
    public var line1: Failable<String?, NotNilValidate<Length300>>
    
    /// The second line of the address. For example, suite or apartment number.
    public var line2: Failable<String?, NotNilValidate<Length300>>
    
    /// The highest level sub-division in a country, which is usually a province, state, or ISO-3166-2 subdivision.
    /// Format for postal delivery. For example, CA and not California. Value, by country, is:
    ///   - UK. A county.
    ///   - US. A state.
    ///   - Canada. A province.
    ///   - Japan. A prefecture.
    ///   - Switzerland. A kanton.
    public var admin1: Failable<String?, NotNilValidate<Length300>>
    
    /// A city, town, or village. Smaller than admin_area_level_1.
    public var admin2: Failable<String?, NotNilValidate<Length120>>
    
    /// The postal code, which is the zip code or equivalent. Typically required for countries with a
    /// postal code or an equivalent. See [postal code](https://en.wikipedia.org/wiki/Postal_code).
    public var postalCode: Failable<String?, NotNilValidate<Length60>>
    
    /// The [two-character ISO 3166-1 code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/)
    /// that identifies the country or region.
    ///
    /// - Note: The country code for Great Britain is GB and not UK as used in the top-level domain names for that country.
    ///   Use the C2 country code for China worldwide for comparable uncontrolled price (CUP) method, bank card,
    ///   and cross-border transactions.
    public var country: Country
    
    /// Creates a new `Payer.Address` instance.
    ///
    /// - Parameters:
    ///   - line1: The first line of the address.
    ///   - line2: The second line of the address.
    ///   - admin1: The highest level sub-division in a country.
    ///   - admin2: A city, town, or village.
    ///   - postalCode: The postal code, which is the zip code or equivalent.
    ///   - country: The two-character ISO 3166-1 code that identifies the country or region.
    public init(
        line1: Failable<String?, NotNilValidate<Length300>>,
        line2: Failable<String?, NotNilValidate<Length300>>,
        admin1: Failable<String?, NotNilValidate<Length300>>,
        admin2: Failable<String?, NotNilValidate<Length120>>,
        postalCode: Failable<String?, NotNilValidate<Length60>>,
        country: Country
        ) {
        self.line1 = line1
        self.line2 = line2
        self.admin1 = admin1
        self.admin2 = admin2
        self.postalCode = postalCode
        self.country = country
    }
    
    enum CodingKeys: String, CodingKey {
        case line1 = "address_line_1"
        case line2 = "address_line_2"
        case admin1 = "admin_area_1"
        case admin2 = "admin_area_2"
        case postalCode = "postal_code"
        case country = "country_code"
    }
}
