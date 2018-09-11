import Vapor

extension AccountError {
    
    /// Additional details about an error.
    public struct Details: Content, Equatable {
        
        /// The field that caused the error. If the field is in the body, set this value to the JSON pointer to that field. Required for client-side errors.
        public var issue: String
        
        /// The value of the field that caused the error.
        public var field: String?
        
        /// The location of the field that caused the error. Value is `body`, `path`, or `query`.
        ///
        /// Default: `body`.
        public var value: String?
        
        /// The unique and fine-grained application-level error code.
        public var location: String?
        
        /// The human-readable description for an issue. The description MAY change over the lifetime of an API, so clients **MUST NOT** depend on this value.
        public var description: String?
        
        
        /// Creates a new `AccountError.Details` instance.
        ///
        /// - Parameters:
        ///   - issue: The field that caused the error.
        ///   - field: The value of the field that caused the error.
        ///   - value: The location of the field that caused the error.
        ///   - location: The unique and fine-grained application-level error code.
        ///   - description: The human-readable description for an issue.
        public init(issue: String, field: String? = nil, value: String? = nil, location: String? = nil, description: String? = nil) {
            self.issue = issue
            self.field = field
            self.value = value
            self.location = location
            self.description = description
        }
    }
}
