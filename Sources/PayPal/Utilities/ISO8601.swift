import Foundation

// Credit to @LeoDabus on StackOverflow for this formatter.
// https://stackoverflow.com/questions/28016578/swift-how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-tim#28016692
extension DateFormatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

extension Date {
    var iso8601: String {
        return DateFormatter.iso8601.string(from: self)
    }
}