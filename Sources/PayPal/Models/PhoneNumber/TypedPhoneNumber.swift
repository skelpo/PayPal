import Vapor

/// A phone number with a defined phone type that the number is connected to.
public struct TypedPhoneNumber: Content, ValidationSetable, Equatable {
    
    /// The type of phone.
    public var type: PhoneType
    
    /// The country calling code (CC), as defined by the [E.164 numbering plan](https://www.itu.int/rec/T-REC-E.164/en).
    /// The combined length of the country code and the national number cannot exceed 15 digits.
    ///
    /// This property can be set using the `TypedPhoneNumber.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Minimum length: 1. Maximum length: 3. Pattern: `^[0-9]{1,3}?$`.
    public private(set) var country: String
    
    /// The national number, as defined by the [E.164 numbering plan](https://www.itu.int/rec/T-REC-E.164/en).
    /// The combined length of of the country code and the national number cannot exceed 15 digits.
    /// The national number consists of national destination code (NDC) and subscriber number (SN).
    ///
    /// This property can be set using the `TypedPhoneNumber.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Minimum length: 1. Maximum length: 14. Pattern: `^[0-9]{1,14}?$`.
    public private(set) var nationalNumber: String
    
    /// The extension number.
    ///
    /// This property can be set using the `TypedPhoneNumber.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Minimum length: 1. Maximum length: 15. Pattern: `^[0-9]{1,15}?$`.
    public private(set) var `extension`: String?
    
    
    /// Creates a new `TypePhoneNumber` instance.
    ///
    ///     TypedPhoneNumber(type: .home, country: "1", nationalNumber: "5838954290", extension: "777")
    public init(type: PhoneType, country: String, nationalNumber: String, `extension`: String?)throws {
        self.type = type
        self.country = country
        self.nationalNumber = nationalNumber
        self.extension = `extension`
        
        try self.set(\.country <~ country)
        try self.set(\.nationalNumber <~ nationalNumber)
        try self.set(\.`extension` <~ `extension`)
    }
    
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let country = try container.decode(String.self, forKey: .country)
        let nationalNumber = try container.decode(String.self, forKey: .nationalNumber)
        let `extension` = try container.decodeIfPresent(String.self, forKey: .extension)
        
        self.country = country
        self.nationalNumber = nationalNumber
        self.extension = `extension`
        self.type = try container.decode(PhoneType.self, forKey: .type)
        
        try self.set(\.country <~ country)
        try self.set(\.nationalNumber <~ nationalNumber)
        try self.set(\.`extension` <~ `extension`)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<TypedPhoneNumber> {
        var validations = SetterValidations(TypedPhoneNumber.self)
        
        validations.set(\.country) { country in
            guard country.range(of: "^[0-9]{1,3}?$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`country` value must match RegEx pattern `^[0-9]{1,3}?$`")
            }
        }
        validations.set(\.nationalNumber) { number in
            guard number.range(of: "^[0-9]{1,14}?$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`national_number` value must match RegEx pattern `^[0-9]{1,14}?$`")
            }
        }
        validations.set(\.`extension`) { `extension` in
            guard let number = `extension` else { return }
            guard number.range(of: "^[0-9]{1,15}?$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`extension_number` value must match RegEx pattern `^[0-9]{1,15}?$`")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case country = "country_code"
        case nationalNumber = "national_number"
        case `extension` = "extension_number"
    }
}
