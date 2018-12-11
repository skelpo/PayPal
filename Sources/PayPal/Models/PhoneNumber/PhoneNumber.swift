import Vapor

/// A phone number's country code and local number.
public struct PhoneNumber: Content, Equatable {
    
    /// The country code portion of the phone number, in [E.164 format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    ///
    /// Minimum length: 1. Maximum length: 3. Pattern: `^[0-9]{1,3}?$`.
    public var country: Failable<String?, NotNilValidate<CountryNumber>>
    
    /// The in-country phone number, in [E.164 format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    ///
    /// Minimum length: 1. Maximum length: 14. Pattern: `^[0-9]{1,14}?$`.
    public var number: Failable<String?, NotNilValidate<Number>>
    
    /// Creates a new instance of `PhoneNumber`.
    ///
    /// - Parameters:
    ///   - country: The country code portion of the phone number, in E.164 format.
    ///   - number: The in-country phone number, in E.164 format.
    public init(country: Failable<String?, NotNilValidate<CountryNumber>>, number: Failable<String?, NotNilValidate<Number>>) {
        self.country = country
        self.number = number
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country_code"
        case number = "national_number"
    }
}

extension PhoneNumber {
    
    /// The validation for the `PhoneNumber.country` property.
    public struct CountryNumber: RegexValidation {
        
        /// See `RegexValidation.pattern`.
        public static var pattern: String = "^[0-9]{1,3}?$"
    }
    
    /// The validation for the `PhoneNumber.number` property.
    public struct Number: RegexValidation {
        
        /// See `RegexValidation.pattern`.
        public static var pattern: String = "^[0-9]{1,14}?$"
    }
}
