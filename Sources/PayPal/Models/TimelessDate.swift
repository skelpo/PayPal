import Vapor

/// The stand-alone date, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). To represent special legal values,
/// such as a date of birth, you should use dates with no associated time or time-zone data. Whenever possible, use the standard `date_time` type.
public struct TimelessDate: Content, Equatable, ExpressibleByFloatLiteral {
    internal static let threadSafeFormatter: ThreadSpecificVariable<DateFormatter> = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return ThreadSpecificVariable(value: formatter)
    }()
    
    internal static var formatter: DateFormatter? {
        return self.threadSafeFormatter.currentValue
    }
    
    /// The underlying data for the date.
    public var date: Date
    
    /// Creates a new `TimelessDate` instance from a `Date`.
    ///
    /// - Parameter date: The `Date` instance.
    public init(_ date: Date) {
        self.date = Calendar(identifier: .iso8601).date(bySettingHour: 0, minute: 0, second: 0, of: date) ?? date
    }
    
    /// Creates a new `TimelessDate` instance from a `String`.
    ///
    /// - Parameter date: The date representation, formatted as `yyyy-mm-dd`.
    public init?(string: String) {
        guard let date = TimelessDate.formatter?.date(from: string) else { return nil }
        self.date = date
    }
    
    /// Creates a new `TimelessDate` instance from a `TimeInterval` (`Double`) instance.
    ///
    /// Do not use the initializer directly. Instead, assign a `TimeInterval` litteral to a
    /// variable of type `TimelessDate`:
    ///
    ///     let date: TimelessDate = 981_244_800_000
    ///
    /// - Parameter floatLiteral: The timestamp to use for the date.
    public init(floatLiteral value: TimeInterval) {
        self.date = Date(timeIntervalSince1970: value)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        
        guard let date = TimelessDate.formatter?.date(from: raw) else {
            throw PayPalError(
                status: .badRequest,
                identifier: "dateFormat",
                reason: "Expected date to be formatted as `yyyy-mm-dd`"
            )
        }
        self.date = date
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        let raw = TimelessDate.formatter?.string(from: self.date)
        try container.encode(raw)
    }
}
