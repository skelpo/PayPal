import Vapor

extension AccountError {
    public struct Details: Content, Equatable {
        public var issue: String
        public var field: String?
        public var value: String?
        public var location: String?
        public var description: String?
        
        public init(issue: String, field: String? = nil, value: String? = nil, location: String? = nil, description: String? = nil) {
            self.issue = issue
            self.field = field
            self.value = value
            self.location = location
            self.description = description
        }
    }
}
