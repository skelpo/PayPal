import Foundation

// Credit to @LeoDabus on StackOverflow for this formatter.
// https://stackoverflow.com/questions/28016578/swift-how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-tim#28016692
extension DateFormatter {
    
    /// A formatter for ISO 8601 dates.
    ///
    /// The date format pattern is `yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX`, so a `Date` instance
    /// converted to a string will look something like this:
    ///
    ///     "2019-03-04T11:28:36.000Z"
    public static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

extension Date {
    
	/// Converts a `Date` instance to an ISO 8601 string.
	public var iso8601: String {
		if #available(OSX 10.12, *) {
			return ISO8601DateFormatter().string(from: self)
		} else if let fmt = DateFormatter.iso8601 as? DateFormatter {
			return fmt.string(from: self)
		}

		return self.description
	}
    
    /// Creates a `Date` instance from a string which contains an ISO 8601 dats.
    ///
    /// - Parameter iso8601: The string that has the date.
    public init?(iso8601: String) {
        guard let date = DateFormatter.iso8601.date(from: iso8601) else { return nil }
        self = date
    }
}

/// A `Date` container that encodes/decodes the instance as an ISO8601 string.
public struct ISO8601Date: Codable, Hashable {
    
    /// The `Date` instance that the `ISO8601Date` instance wraps.
    public let date: Date
    
    /// The string that the `date` property was decoded from.
    public let raw: String?
    
    /// Creates a new `ISO8601Date` instance from a `Date`.
    ///
    /// - Parameter date: The `Date` instance to wrap.
    public init(_ date: Date) {
        self.date = date
        self.raw = nil
    }
    
    /// Creates a new `ISOL8601Date` instance from a formatted date string.
    ///
    /// If a `Date` instance cannnot be created from the string passed in, `nil` will be returned from the initializer.
    ///
    /// - Parameter string: The string to decode the `Date` from.
    ///   This is also the value that the `raw` property will be set to.
    public init?(string: String) {
        guard let date = Date(iso8601: string) else {
            return nil
        }
        
        self.date = date
        self.raw = string
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let decoder = try decoder.singleValueContainer()
        let raw = try decoder.decode(String.self)
        guard let date = Date(iso8601: raw) else {
            throw DecodingError.dataCorruptedError(in: decoder, debugDescription: "Invalid date format for string `\(raw)`")
        }
        
        self.raw = raw
        self.date = date
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder)throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.date.iso8601)
    }
    
    /// See [`Equatable.==(lhs:rhs:)`](https://developer.apple.com/documentation/swift/equatable/1539854).
    public static func ==(lhs: ISO8601Date, rhs: ISO8601Date) -> Bool {
        let lRaw = lhs.raw ?? lhs.date.iso8601
        let rRaw = rhs.raw ?? rhs.date.iso8601
        
        return lRaw == rRaw
    }
}

/// Compares the ISO8601 string of the date wrapped by a `ISO8601Date` instance and another `Date` instance.
///
/// - Parameters:
///   - lhs: The `ISO8601Date` instance check against the `Date` on the right.
///   - rhs: The `Date` instance to check against the instance wrapped by the `ISO8601Date`.
///
/// - Returns: A boolean indicating whether the ISO8601 strings of the `Date` instances match or not.
public func ==(lhs: ISO8601Date, rhs: Date) -> Bool {
    return lhs.date.iso8601 == rhs.iso8601
}
