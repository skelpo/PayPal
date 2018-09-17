import Vapor

/// A country specific phone number.
public struct DisplayPhone: Content, ValidationSetable, Equatable {
    
    /// The [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/) of the payee's country.
    ///
    /// This property can be set using the `DisplayPhone.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    public private(set) var country: String?
    
    /// The in-country phone number, in [E.164 numbering plan format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    public var number: String?
    
    /// Creates a new `DisplayPhone` instance.
    ///
    /// - Parameters:
    ///   - country: The country code of the payee's country.
    ///   - number: The in-country phone number.
    public init(country: String?, number: String?)throws {
        self.country = country
        self.number = number
        
        try self.set(\.country <~ country)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            country: container.decodeIfPresent(String.self, forKey: .country),
            number: container.decodeIfPresent(String.self, forKey: .number)
        )
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<DisplayPhone> {
        var validations = SetterValidations(DisplayPhone.self)
        
        validations.set(\.country) { country in
            guard let country = country else { return }
            guard country.range(of: "^([A-Z]{2}|C2)$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`country` value must match RegEx pattern '^([A-Z]{2}|C2)$'")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country_code"
        case number
    }
}
