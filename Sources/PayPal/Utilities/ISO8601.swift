import Foundation

// Credit to @LeoDabus on StackOverflow for this formatter.
// https://stackoverflow.com/questions/28016578/swift-how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-tim#28016692
extension DateFormatter {
    
    /// A formatter for ISO 8601 dates.
    public static let iso8601: Formatter = {
        if #available(OSX 10.12, *) {
            return ISO8601DateFormatter()
        } else {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }
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
        let converter: ((String) -> Date?)?
        if #available(OSX 10.12, *) {
            converter = (DateFormatter.iso8601 as? ISO8601DateFormatter)?.date
        } else {
            converter = (DateFormatter.iso8601 as? DateFormatter)?.date
        }
        guard let date = converter?(iso8601) else { return nil }
        self = date
    }
}

public struct ISO8601Date: Codable, Hashable {
    public let date: Date
    public let raw: String?
    
    public init(_ date: Date) {
        self.date = date
        self.raw = nil
    }
    
    public init?(string: String) {
        guard let date = Date(iso8601: string) else {
            return nil
        }
        
        self.date = date
        self.raw = string
    }
    
    public init(from decoder: Decoder)throws {
        let decoder = try decoder.singleValueContainer()
        let raw = try decoder.decode(String.self)
        guard let date = Date(iso8601: raw) else {
            throw DecodingError.dataCorruptedError(in: decoder, debugDescription: "Invalid date format for string `\(raw)`")
        }
        
        self.raw = raw
        self.date = date
    }
    
    public func encode(to encoder: Encoder)throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.date.iso8601)
    }
    
    public static func ==(lhs: ISO8601Date, rhs: ISO8601Date) -> Bool {
        let lRaw = lhs.raw ?? lhs.date.iso8601
        let rRaw = rhs.raw ?? rhs.date.iso8601
        
        return lRaw == rRaw
    }
}

public func ==(lhs: ISO8601Date, rhs: Date) -> Bool {
    return lhs.date.iso8601 == rhs.iso8601
}
