import Vapor

/// A phone number's country code and local number.
public struct PhoneNumber: Content, Equatable {
    
    /// The country code portion of the phone number, in [E.164 format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    ///
    /// Minimum length: 1. Maximum length: 3. Pattern: `^[0-9]{1,3}?$`.
    public var country: Failable<Int?, NotNilValidate<CountryNumber>>
    
    /// The in-country phone number, in [E.164 format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    ///
    /// Minimum length: 1. Maximum length: 14. Pattern: `^[0-9]{1,14}?$`.
    public var number: Failable<Int?, NotNilValidate<Number>>
    
    /// Creates a new instance of `PhoneNumber`.
    ///
    /// - Parameters:
    ///   - country: The country code portion of the phone number, in E.164 format.
    ///   - number: The in-country phone number, in E.164 format.
    public init(country: Failable<Int?, NotNilValidate<CountryNumber>>, number: Failable<Int?, NotNilValidate<Number>>) {
        self.country = country
        self.number = number
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let countryStr = try container.decodeIfPresent(String.self, forKey: .country) {
            guard let country = Int(countryStr) else {
                throw DecodingError.dataCorruptedError(forKey: .country, in: container, debugDescription: "String must be convertible to integer")
            }
            self.country = try .init(country)
        } else {
            self.country = nil
        }
        
        if let numberStr = try container.decodeIfPresent(String.self, forKey: .number) {
            guard let number = Int(numberStr) else {
                throw DecodingError.dataCorruptedError(forKey: .number, in: container, debugDescription: "String must be convertible to integer")
            }
            self.number = try .init(number)
        } else {
            self.number = nil
        }
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder)throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let country = self.country.value {
            try container.encode(String(describing: country), forKey: .country)
        }
        if let number = self.number.value {
            try container.encode(String(describing: number), forKey: .number)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country_code"
        case number = "national_number"
    }
}

extension PhoneNumber {
    
    /// The validation for the `PhoneNumber.country` property.
    public struct CountryNumber: InRangeValidation {
        
        /// See `Validation.Supported`.
        public typealias Supported = Int
        
        /// The `PhoneNumber.country` value must be 999 or less.
        public static var max: Int? = 999
        
        /// The `PhoneNumber.country` value must be 0 or more.
        public static var min: Int? = 0
    }
    
    /// The validation for the `PhoneNumber.number` property.
    public struct Number: InRangeValidation {
        
        /// See `Validation.Supported`.
        public typealias Supported = Int
        
        /// The `PhoneNumber.country` value must be 99,999,999,999,999 or less.
        public static var max: Int? = 99_999_999_999_999
        
        /// The `PhoneNumber.country` value must be 0 or more.
        public static var min: Int? = 0
    }
}
