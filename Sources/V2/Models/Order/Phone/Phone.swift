import Failable

/// The phone number of a customer, merchant, or organization.
public struct Phone: Codable {
    
    /// The country calling code (CC), in its canonical international
    /// [E.164 numbering plan format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the CC and the
    /// national number must not be greater than 15 digits. The national number consists of a national
    /// destination code (NDC) and subscriber number (SN).
    public var country: Failable<Int, CountryCode>
    
    /// The national number, in its canonical international
    /// [E.164 numbering plan format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the country
    /// calling code (CC) and the national number must not be greater than 15 digits. The national number consists
    /// of a national destination code (NDC) and subscriber number (SN).
    public var national: Failable<Int, NationalNumber>
    
    /// The extension number.
    public var `extension`: Failable<Int?, NotNilValidate<ExtensionNumber>>
    
    /// Creates a new `Phone` instance.
    ///
    /// - Parameters:
    ///   - country: The country calling code (CC), in its canonical international E.164 numbering plan format.
    ///   - national: The national number, in its canonical international E.164 numbering plan format.
    ///   - extension: The extension number.
    public init(
        country: Failable<Int, CountryCode>,
        national: Failable<Int, NationalNumber>,
        `extension`: Failable<Int?, NotNilValidate<ExtensionNumber>>
    ) {
        self.country = country
        self.national = national
        self.extension = `extension`
    }
    
    /// The validation for the `Phone.country` property value.
    public struct CountryCode: InRangeValidation {
        
        /// See `Validation.Supported`.
        public typealias Supported = Int
        
        /// See `InRangeValidation.min`.
        ///
        /// The minumum allowed value is `0`.
        public static let min: Int? = 0
        
        /// See `InRangeValidation.max`.
        ///
        /// The minumum allowed value is `999`.
        public static let max: Int? = 999
    }
    
    /// The validation for the `Phone.national` property value.
    public struct NationalNumber: InRangeValidation {
        
        /// See `Validation.Supported`.
        public typealias Supported = Int
        
        /// See `InRangeValidation.min`.
        ///
        /// The minumum allowed value is `0`.
        public static let min: Int? = 0
        
        /// See `InRangeValidation.max`.
        ///
        /// The minumum allowed value is `99,999,999,999,999`.
        public static let max: Int? = 99_999_999_999_999
    }
    
    /// The validation for the `Phone.extension` property value.
    public struct ExtensionNumber: InRangeValidation {
        
        /// See `Validation.Supported`.
        public typealias Supported = Int
        
        /// See `InRangeValidation.min`.
        ///
        /// The minumum allowed value is `0`.
        public static let min: Int? = 0
        
        /// See `InRangeValidation.max`.
        ///
        /// The minumum allowed value is `999,999,999,999,999`.
        public static let max: Int? = 999_999_999_999_999
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country_code"
        case national = "national_number"
        case `extension` = "extension_number"
    }
}
