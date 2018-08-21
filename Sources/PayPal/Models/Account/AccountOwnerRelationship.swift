import Vapor

/// A family relationship of an account owner.
public struct AccountOwnerRelationship: Content, ValidationSetable, Equatable {
    
    /// The name of the familial relation.
    public var name: Name
    
    /// The type of familial relationship. Value is `MOTHER`.
    public var relation: String
    
    /// The country code for the nationality of the familial relation.
    ///
    /// This property can be set using the `AccountOwnerRelationship.set(_:)` method.
    /// This method will validate the new value before assigning it to the property.
    ///
    /// Length: 2. Pattern: `^([A-Z]{2}|C2)$`.
    public private(set) var country: String
    
    
    /// Creates a new `AccountOwnerRelationship` instance.
    ///
    ///     AccountOwnerRelationship(name: Name(prefix: nil, given: "Abe", surname: "Lincon", middle: nil, suffix: nil, full: "Abe Lincon"), country: "US")
    public init(name: Name, country: String)throws {
        self.name = name
        self.country = country
        self.relation = "MOTHER"
        
        try self.set(\.country <~ country)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let country = try container.decode(String.self, forKey: .country)
        
        self.country = country
        self.name = try container.decode(Name.self, forKey: .name)
        self.relation = try container.decode(String.self, forKey: .relation)
        
        try self.set(\.country <~ country)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<AccountOwnerRelationship> {
        var validations = SetterValidations(AccountOwnerRelationship.self)
        
        validations.set(\.country) { country in
            guard country.range(of: "^([A-Z]{2}|C2)$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`country` value must match RegEx pattern `^([A-Z]{2}|C2)$`")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case name, relation
        case country = "country_code_of_nationality"
    }
}
