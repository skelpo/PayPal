import Foundation
import PayPal
import NIO

/// A date that only contains year and month information, like a credit card expiration date.
public struct YearMonthDate: Codable {
    internal static let typeSafeFormatter: ThreadSpecificVariable<DateFormatter> = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM"
        return ThreadSpecificVariable(value: formatter)
    }()
    
    internal static var formatter: DateFormatter? {
        return YearMonthDate.typeSafeFormatter.currentValue
    }
    
    /// The underlying date instance.
    public var date: Date
    
    /// Creates a new `YearMonthDate` instance from a `Date`.
    ///
    /// - Parameter date: The `Date` instance to initialize from. The date that will be stored will have all
    ///   information except that year and month removed, so `2019-04-02 20:16:53 +0000` becomes `2019-04-01 00:00:00 +0000`.
    public init(_ date: Date) {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
        self.date = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) ?? date
    }
    
    /// Creates a new `YearMonthDate` instance from a `String` containg that date information.
    ///
    /// - Parameter string: The string with the date information, using the `yyyy-MM` format.
    ///   If a date cannot be extracted from the string, the initializer will return `nil`.
    public init?(string: String) {
        guard let date = YearMonthDate.formatter?.date(from: string) else { return nil }
        self.date = date
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let string = try decoder.singleValueContainer().decode(String.self)
        guard let date = YearMonthDate.formatter?.date(from: string) else {
            throw DecodingError.typeMismatch(
                Date.self,
                DecodingError.Context(codingPath: [], debugDescription: "Cannot get date from string `\(string)`")
            )
        }
        
        self.date = date
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder)throws {
        var container = encoder.singleValueContainer()
        guard let string = YearMonthDate.formatter?.string(from: date) else {
            throw PayPalError(
                status: .internalServerError,
                identifier: "missingFormatter",
                reason: "No date formatter has been initialized for the current thread for `YearMonthDate`"
            )
        }
        
        try container.encode(string)
    }
}
