import Vapor

/// A phone number with a defined phone type that the number is connected to.
public struct TypedPhoneNumber: Content, Equatable {
    
    /// The type of phone.
    public var type: PhoneType
    
    /// The country calling code (CC), as defined by the [E.164 numbering plan](https://www.itu.int/rec/T-REC-E.164/en).
    /// The combined length of the country code and the national number cannot exceed 15 digits.
    ///
    /// Minimum length: 1. Maximum length: 3. Pattern: `^[0-9]{1,3}?$`.
    public var country: Failable<Int, PhoneNumber.CountryNumber>
    
    /// The national number, as defined by the [E.164 numbering plan](https://www.itu.int/rec/T-REC-E.164/en).
    /// The combined length of of the country code and the national number cannot exceed 15 digits.
    /// The national number consists of national destination code (NDC) and subscriber number (SN).
    ///
    /// Minimum length: 1. Maximum length: 14. Pattern: `^[0-9]{1,14}?$`.
    public var nationalNumber: Failable<Int, PhoneNumber.Number>
    
    /// The extension number.
    ///
    /// Minimum length: 1. Maximum length: 15. Pattern: `^[0-9]{1,15}?$`.
    public var `extension`: Failable<Int?, NotNilValidate<Extension>>
    
    
    /// Creates a new `TypePhoneNumber` instance.
    ///
    /// - Parameters:
    ///   - type: The type of phone.
    ///   - country: The country calling code (CC), as defined by the E.164 numbering plan.
    ///   - nationalNumber: The national number, as defined by the E.164 numbering plan.
    ///   - extension: The extension number.
    public init(
        type: PhoneType,
        country: Failable<Int, PhoneNumber.CountryNumber>,
        nationalNumber: Failable<Int, PhoneNumber.Number>,
        `extension`: Failable<Int?, NotNilValidate<Extension>>
    ) {
        self.type = type
        self.country = country
        self.nationalNumber = nationalNumber
        self.extension = `extension`
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let country = try Int(container.decode(String.self, forKey: .country)) else {
            throw DecodingError.dataCorruptedError(forKey: .country, in: container, debugDescription: "String must be convertible to integer")
        }
        guard let nationalNumber = try Int(container.decode(String.self, forKey: .nationalNumber)) else {
            throw DecodingError.dataCorruptedError(forKey: .nationalNumber, in: container, debugDescription: "String must be convertible to integer")
        }
        
        self.type = try container.decode(PhoneType.self, forKey: .type)
        self.country = try country.failable()
        self.nationalNumber = try nationalNumber.failable()
        
        if let `extension` = try container.decodeIfPresent(String.self, forKey: .`extension`) {
            guard Int(`extension`) != nil else {
                throw DecodingError.dataCorruptedError(forKey: .extension, in: container, debugDescription: "String must be convertible to integer")
            }
            self.extension = try .init(Int(`extension`))
        } else {
            self.extension = nil
        }
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder)throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(String(describing: self.country.value), forKey: .country)
        try container.encode(String(describing: self.nationalNumber.value), forKey: .nationalNumber)
        
        if let `extension` = self.extension.value {
            try container.encode(String(describing: `extension`), forKey: .`extension`)
        }
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
    public struct Extension: InRangeValidation {
        
        /// See `Validation.Supported`.
        public typealias Supported = Int
        
        /// The `TypedPhoneNumber.extension` value must be 999,999,999,999,999 or less.
        public static var max: Int? = 999_999_999_999_999
        
        /// The `TypedPhoneNumber.extension` value must be 0 or more.
        public static var min: Int? = 0
    }
}
