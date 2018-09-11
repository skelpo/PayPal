import Vapor

public struct PartnerOptions: Content, Equatable {
    public var fields: [KeyValue]
    
    public init(fields: [KeyValue]) {
        self.fields = fields
    }
}
