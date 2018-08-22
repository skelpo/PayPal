import Vapor

/// The place of establishment of an organization or business.
public struct Establishment: Content, Equatable {
    
    /// The [state or territory](https://developer.paypal.com/docs/integration/direct/rest/state-codes/)
    /// of the government body with which the business was established.
    public var state: String?
    
    /// The [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/)
    /// of the country where the business was established.
    ///
    /// - Note: The country code for Great Britain is `GB` and not `UK` as used in the top-level domain names for that country.
    ///   Use the `C2 country code for China worldwide for comparable uncontrolled price (CUP) method, bank card, and cross-border transactions.
    ///
    /// Length: 2. Pattern: `^([A-Z]{2}|C2)$`.
    public var country: String?
    
    
    /// Creates a new `Establishment` instance.
    ///
    ///     Establishment(state: "KS", country: "US")
    public init(state: String?, country: String?) {
        self.state = state
        self.country = country
    }
    
    enum CodingKeys: String, CodingKey {
        case state
        case country = "country_code"
    }
}
