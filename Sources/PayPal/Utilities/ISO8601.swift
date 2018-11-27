import Foundation

// Credit to @LeoDabus on StackOverflow for this formatter.
// https://stackoverflow.com/questions/28016578/swift-how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-tim#28016692
extension DateFormatter {
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
    public var iso8601: String {
        return DateFormatter.iso8601.string(for: self) ?? self.description
    }
    
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
