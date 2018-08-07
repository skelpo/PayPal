import Vapor

/// A phone number's country code and local number.
public struct PhoneNumber: Content, Equatable {
    
    /// The country code portion of the phone number, in [E.164 format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    ///
    /// This property can be set using the `PhoneNumber.set(_:)`. This method will validate
    /// the new value before assigning it to the property.
    ///
    /// Minimum length: 1. Maximum length: 3. Pattern: `^[0-9]{1,3}?$`.
    public var country: String
    
    
    /// The in-country phone number, in [E.164 format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    ///
    /// This property can be set using the `PhoneNumber.set(_:)`. This method will validate
    /// the new value before assigning it to the property.
    ///
    /// Minimum length: 1. Maximum length: 14. Pattern: `^[0-9]{1,14}?$`.
    public var number: String
    
    /// Creates a new instance of `PhoneNumber`.
    ///
    ///     PhoneNumber(country: "1", number: "9963191901")
    public init(country: String, number: String)throws {
        self.country = country
        self.number = number
    }
}
