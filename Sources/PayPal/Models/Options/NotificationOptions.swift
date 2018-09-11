import Vapor

public struct NotificationOptions: Content, Equatable {
    public var suppressWelcome: Bool?
    public var ipnNotify: String?
    public var emailFrequency: EmailFrequency?
    
    public init(suppressWelcome: Bool? = nil, ipnNotify: String? = nil, emailFrequency: EmailFrequency? = nil) {
        self.suppressWelcome = suppressWelcome
        self.ipnNotify = ipnNotify
        self.emailFrequency = emailFrequency
    }
}

extension NotificationOptions {
    public enum EmailFrequency: String, Hashable, CaseIterable, Content {
        case `default` = "DEFAULT"
        case none = "NONE"
    }
}
