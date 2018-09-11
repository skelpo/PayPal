import Vapor

/// A relationship between two accounts, primerily as a parent/child relationship.
public struct AccountRelation: Content, Equatable {
    
    /// The type of relationship.
    public var type: RelationType
    
    /// The payer ID of the subject.
    public var payer: String?
    
    /// Creates a new `AccountRelation` instance.
    ///
    ///     AccountRelation(type: .partner, payer: "8D2CC62B-06AF-4285-8AEF-1178E29B5424")
    ///
    /// - Parameters:
    ///   - type: The type of relationship.
    ///   - payer: The payer ID of the subject.
    public init(type: RelationType, payer: String?) {
        self.type = type
        self.payer = payer
    }
}
