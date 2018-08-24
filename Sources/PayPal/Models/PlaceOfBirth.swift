import Vapor

/// The birthplace of a human, robot, orangutang, or anything else that originates on planet earth.
public struct BirthPlace: Content, ValidationSetable, Equatable {
    
    /// The two-character ISO 3166-1 code that identifies the country or region.
    ///
    /// - Note: he country code for Great Britain is `GB` and not `UK` as used in the top-level domain names for that country.
    ///   Use the `C2` country code for China worldwide for comparable uncontrolled price (CUP) method, bank card, and cross-border transactions.
    ///
    /// This property can be set using the `BirthPlace.set(_:)` method. This method
    /// validates the new value before assigning it to the property.
    ///
    /// Length: 2. Pattern: `^([A-Z]{2}|C2)$`.
    public private(set) var country: String?
    
    /// The city of birth.
    public var city: String?
    
    
    /// Creates a new `BirthPlace` instance.
    ///
    ///     BirthPlace(country: "US", city: "Seattle")
    public init(country: String?, city: String?)throws {
        self.country = country
        self.city = city
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<BirthPlace> {
        var validations = SetterValidations(BirthPlace.self)
        
        validations.set(\.country) { country in
            guard let country = country else { return }
            guard country.range(of: "^([A-Z]{2}|C2)$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`country` value must match RegEx pattern `^([A-Z]{2}|C2)$`")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country_code"
        case city
    }
}
