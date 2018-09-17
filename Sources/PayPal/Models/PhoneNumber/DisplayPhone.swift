import Vapor

/// A country specific phone number.
public struct DisplayPhone: Content, Equatable {
    
    /// The [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/) of the payee's country.
    public var country: String?
    
    /// The in-country phone number, in [E.164 numbering plan format](https://www.itu.int/rec/T-REC-E.164-201011-I).
    public var number: String?
    
    /// Creates a new `DisplayPhone` instance.
    ///
    /// - Parameters:
    ///   - country: The country code of the payee's country.
    ///   - number: The in-country phone number.
    public init(country: String?, number: String?) {
        self.country = country
        self.number = number
    }
}
