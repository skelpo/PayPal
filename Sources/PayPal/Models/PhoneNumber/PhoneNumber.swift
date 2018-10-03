import Vapor

/// A phone number's country code and local number.
public struct PhoneNumber: Content, ValidationSetable, Equatable {
    
    /// The country code portion of the phone number, in [E.164 format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    ///
    /// This property can be set using the `PhoneNumber.set(_:)`. This method will validate
    /// the new value before assigning it to the property.
    ///
    /// Minimum length: 1. Maximum length: 3. Pattern: `^[0-9]{1,3}?$`.
    public private(set) var country: String?
    
    /// The in-country phone number, in [E.164 format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    ///
    /// This property can be set using the `PhoneNumber.set(_:)`. This method will validate
    /// the new value before assigning it to the property.
    ///
    /// Minimum length: 1. Maximum length: 14. Pattern: `^[0-9]{1,14}?$`.
    public private(set) var number: String?
    
    /// Creates a new instance of `PhoneNumber`.
    ///
    ///     PhoneNumber(country: "1", number: "9963191901")
    public init(country: String?, number: String?)throws {
        self.country = country
        self.number = number
        
        try self.set(\.country <~ country)
        try self.set(\.number <~ number)
    }
    
    /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        
        try self.set(\.country <~ country)
        try self.set(\.number <~ number)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<PhoneNumber> {
        var validations = SetterValidations(PhoneNumber.self)
        
        validations.set(\.country) { country in
            if country == nil { return }
            guard country?.range(of: "^[0-9]{1,3}?$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`country` property value must match '^[0-9]{1,3}?$' RegEx pattern")
            }
        }
        validations.set(\.number) { number in
            if number == nil { return }
            guard number?.range(of: "^[0-9]{1,14}?$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`number` property value must match '^[0-9]{1,14}?$' RegEx pattern")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country_code"
        case number = "national_number"
    }
}
