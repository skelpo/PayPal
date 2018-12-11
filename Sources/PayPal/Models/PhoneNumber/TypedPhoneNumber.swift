import Vapor

/// A phone number with a defined phone type that the number is connected to.
public struct TypedPhoneNumber: Content, Equatable {
    
    /// The type of phone.
    public var type: PhoneType
    
    /// The country calling code (CC), as defined by the [E.164 numbering plan](https://www.itu.int/rec/T-REC-E.164/en).
    /// The combined length of the country code and the national number cannot exceed 15 digits.
    ///
    /// Minimum length: 1. Maximum length: 3. Pattern: `^[0-9]{1,3}?$`.
    public var country: Failable<String, PhoneNumber.CountryNumber>
    
    /// The national number, as defined by the [E.164 numbering plan](https://www.itu.int/rec/T-REC-E.164/en).
    /// The combined length of of the country code and the national number cannot exceed 15 digits.
    /// The national number consists of national destination code (NDC) and subscriber number (SN).
    ///
    /// Minimum length: 1. Maximum length: 14. Pattern: `^[0-9]{1,14}?$`.
    public var nationalNumber: Failable<String, PhoneNumber.Number>
    
    /// The extension number.
    ///
    /// Minimum length: 1. Maximum length: 15. Pattern: `^[0-9]{1,15}?$`.
    public var `extension`: Failable<String?, NotNilValidate<Extension>>
    
    
    /// Creates a new `TypePhoneNumber` instance.
    ///
    /// - Parameters:
    ///   - type: The type of phone.
    ///   - country: The country calling code (CC), as defined by the E.164 numbering plan.
    ///   - nationalNumber: The national number, as defined by the E.164 numbering plan.
    ///   - extension: The extension number.
    public init(
        type: PhoneType,
        country: Failable<String, PhoneNumber.CountryNumber>,
        nationalNumber: Failable<String, PhoneNumber.Number>,
        `extension`: Failable<String?, NotNilValidate<Extension>>
    ) {
        self.type = type
        self.country = country
        self.nationalNumber = nationalNumber
        self.extension = `extension`
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case country = "country_code"
        case nationalNumber = "national_number"
        case `extension` = "extension_number"
    }
}

extension TypedPhoneNumber {
    
    /// The validation for the `TypedPhoneNumber.extension` property.
    public struct Extension: RegexValidation {
        
        /// See `RegexValidation.pattern`.
        public static var pattern: String = "^[0-9]{1,15}?$"
    }
}
