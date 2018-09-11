import Vapor

public struct AccountRelation: Content, Equatable {
    public var type: RelationType
    public var payer: String?
    
    public init(type: RelationType, payer: String?) {
        self.type = type
        self.payer = payer
    }
}
