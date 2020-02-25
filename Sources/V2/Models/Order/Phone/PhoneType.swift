import Failable

/// The type of phone that a phone number is connected to.
public enum PhoneType: String, Hashable, Codable, CaseIterable {
    
    /// `FAX` type.
    case fax = "FAX"
    
    /// `HOME` type.
    case home = "HOME"
    
    /// `MOBILE` type.
    case mobile = "MOBILE"
    
    /// `OTHER` type.
    case other = "OTHER"
    
    /// `PAGER` type.
    case pager = "PAGER"
}

/// A phone number that has a specified phone type it is connected to.
public struct TypedPhone: Codable {
    
    /// The phone type.
    public var type: PhoneType?
    
    /// The national number, in its canonical international
    /// [E.164 numbering plan format](https://www.itu.int/rec/T-REC-E.164/en). The combined length of the country
    /// calling code (CC) and the national number must not be greater than 15 digits. The national number
    /// consists of a national destination code (NDC) and subscriber number (SN).
    ///
    /// - Note: To be compatible with the PayPal API, this value is encoded/decoded as a `String`.
    public var national: Failable<Int, Phone.NationalNumber>
    
    /// Creates a new `TypedPhone` instance.
    ///
    /// - Parameters:
    ///   - type: The phone type.
    ///   - national: The national number, in its canonical international E.164 numbering plan format
    public init(type: PhoneType?, national: Failable<Int, Phone.NationalNumber>) {
        self.type = type
        self.national = national
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(PhoneType.self, forKey: .type)
        
        let number = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .number)
        guard let int = try Int(number.decode(String.self, forKey: .national)) else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.national,
                in: number,
                debugDescription: "`phone_number.national_number` string value must be convertible to an int"
            )
        }
        self.national = try Failable(int)
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.type, forKey: .type)
        
        var number = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .number)
        try number.encode(String(describing: self.national.value), forKey: .national)
    }
    
    enum CodingKeys: String, CodingKey {
        case type = "phone_type"
        case number = "phone_number"
        case national = "national_number"
    }
}
