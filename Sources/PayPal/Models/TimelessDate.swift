import Vapor

/// Date information without a timestamp.
public struct TimelessDate: Content, ValidationSetable, Equatable {
    
    /// The stand-alone date, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). To represent special legal values,
    /// such as a date of birth, you should use dates with no associated time or time-zone data. Whenever possible, use the standard `date_time` type.
    /// This regular expression does not validate all dates. For example, February 31 is valid and nothing is known about leap years.
    ///
    /// This property can be set using the `TimelessDate.set(_:)` method, This method
    /// validates the new value before assigning it to the property.
    ///
    /// Length: 10. Pattern: `^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$`.
    public private(set) var date: String?
    
    
    /// Creates a new `TimelessDate` instance.
    ///
    ///     TimelessDate(date: "1517-10-31")
    public init(date: String?)throws {
        self.date = date
        
        try self.set(\.date <~ date)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let date = try container.decodeIfPresent(String.self, forKey: .date)
        
        self.date = date
        
        try self.set(\.date <~ date)
    }
    
    /// See `ValidationSetable.setterValidations()`
    public func setterValidations() -> SetterValidations<TimelessDate> {
        var validations = SetterValidations(TimelessDate.self)
        
        validations.set(\.date) { date in
            let pattern = "^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$"
            guard date?.range(of: pattern, options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`date` value must match RegEx pattern `\(pattern)`")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "date_no_time"
    }
}
