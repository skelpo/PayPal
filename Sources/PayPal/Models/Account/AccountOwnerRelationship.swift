import Countries
import Vapor

/// A family relationship of an account owner.
public struct AccountOwnerRelationship: Content, Equatable {
    
    /// The name of the familial relation.
    public var name: Name
    
    /// The type of familial relationship. Value is `MOTHER`.
    public var relation: String
    
    /// The country code for the nationality of the familial relation.
    public var country: Country
    
    
    /// Creates a new `AccountOwnerRelationship` instance.
    ///
    ///     AccountOwnerRelationship(
    ///         name: Name(prefix: nil, given: "Abe", surname: "Lincon", middle: nil, suffix: nil, full: "Abe Lincon"),
    ///         country: .unitedStates
    ///     )
    public init(name: Name, country: Country)throws {
        self.name = name
        self.country = country
        self.relation = "MOTHER"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, relation
        case country = "country_code_of_nationality"
    }
}
