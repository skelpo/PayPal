import Vapor

/// The place of establishment of an organization or business.
public struct Establishment: Content, ValidationSetable, Equatable {
    
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
    public private(set) var country: String?
    
    
    /// Creates a new `Establishment` instance.
    ///
    ///     Establishment(state: "KS", country: "US")
    public init(state: String?, country: String?)throws {
        self.state = state
        self.country = country
        
        try self.set(\.country <~ country)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let country = try container.decodeIfPresent(String.self, forKey: .country)
        
        self.country = country
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        
        try self.set(\.country <~ country)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<Establishment> {
        var validations = SetterValidations(Establishment.self)
        
        validations.set(\.country) { country in
            guard let country = country else { return }
            guard country.range(of: "^([A-Z]{2}|C2)$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`country_code` value must match RegEx pattern `^([A-Z]{2}|C2)$`")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case state
        case country = "country_code"
    }
}
