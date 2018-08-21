import Vapor

public struct AccountOwnerRelationship: Content, Equatable {
    public var name: Name
    public var relation: String
    public var country: String
    
    public init(name: Name, country: String) {
        self.name = name
        self.country = country
        self.relation = "MOTHER"
    }
}
