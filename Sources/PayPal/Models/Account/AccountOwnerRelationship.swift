import Vapor

/// A family relationship of an account owner.
public struct AccountOwnerRelationship: Content, Equatable {
    
    /// The name of the familial relation.
    public var name: Name
    
    /// The type of familial relationship. Value is `MOTHER`.
    public var relation: String
    
    /// The country code for the nationality of the familial relation.
    ///
    /// Length: 2. Pattern: `^([A-Z]{2}|C2)$`.
    public var country: String
    
    
    /// Creates a new `AccountOwnerRelationship` instance.
    ///
    ///     AccountOwnerRelationship(name: Name(prefix: nil, given: "Abe", surname: "Lincon", middle: nil, suffix: nil, full: "Abe Lincon", country: "US")
    public init(name: Name, country: String) {
        self.name = name
        self.country = country
        self.relation = "MOTHER"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, relation
        case country = "country_code_of_nationality"
    }
}
