import Vapor

/// The stand-alone date, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6). To represent special legal values,
/// such as a date of birth, you should use dates with no associated time or time-zone data. Whenever possible, use the standard `date_time` type.
public struct TimelessDate: Content, Equatable, ExpressibleByFloatLiteral {
    internal static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    /// The UNIX timestamp for the date being represented.
    ///
    /// This timestamp is converted to a date and then formated for encoding and decoding.
    public var timestamp: TimeInterval?
    
    /// Creates a new `TimelessDate` instance from a `Date`.
    ///
    /// - Parameter date: The `Date` instance to get the timestamp from.
    public init(_ date: Date?) {
        self.timestamp = date?.timeIntervalSince1970
    }
    
    /// Creates a new `TimelessDate` instance from a `String`.
    ///
    /// - Parameter date: The date representation, formatted as `yyyy-mm-dd`.
    public init?(date: String?) {
        guard let string = date, let date = TimelessDate.formatter.date(from: string) else { return nil }
        self.timestamp = date.timeIntervalSince1970
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
        self.timestamp = value
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.timestamp = nil
        } else {
            let raw = try container.decode(String.self)
            guard let date = TimelessDate.formatter.date(from: raw) else {
                throw PayPalError(status: .badRequest, identifier: "dateFormat", reason: "Expected date to be formatted as `yyyy-mm-dd`")
            }
            self.timestamp = date.timeIntervalSince1970
        }
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let timestamp = self.timestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            let raw = TimelessDate.formatter.string(from: date)
            try container.encode(raw)
        }
    }
}
