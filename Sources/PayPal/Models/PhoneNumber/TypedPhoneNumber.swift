import Vapor

/// A phone number with a defined phone type that the number is connected to.
public struct TypedPhoneNumber: Content, Equatable {
    
    /// The type of phone.
    public var type: PhoneType
    
    /// The country calling code (CC), as defined by the [E.164 numbering plan](https://www.itu.int/rec/T-REC-E.164/en).
    /// The combined length of the country code and the national number cannot exceed 15 digits.
    ///
    /// Minimum length: 1. Maximum length: 3. Pattern: `^[0-9]{1,3}?$`.
    public var country: String
    
    /// The national number, as defined by the [E.164 numbering plan](https://www.itu.int/rec/T-REC-E.164/en).
    /// The combined length of of the country code and the national number cannot exceed 15 digits.
    /// The national number consists of national destination code (NDC) and subscriber number (SN).
    ///
    /// Minimum length: 1. Maximum length: 14. Pattern: `^[0-9]{1,14}?$`.
    public var nationalNumber: String
    
    /// The extension number.
    ///
    /// Minimum length: 1. Maximum length: 15. Pattern: `^[0-9]{1,15}?$`.
    public var `extension`: String?
    
    
    /// Creates a new `TypePhoneNumber` instance.
    ///
    ///     TypedPhoneNumber(type: .home, country: "1", nationalNumber: "5838954290", extension: "777")
    public init(type: PhoneType, country: String, nationalNumber: String, `extension`: String?) {
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
