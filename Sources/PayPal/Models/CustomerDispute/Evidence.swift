import Vapor

public struct Evidence: Content, Equatable {
    public var type: EvidenceType?
    public var info: Info?
    public var documents: [Document]?
    public var notes: String?
    public var itemID: String?
    
    public init(type: EvidenceType?, info: Info?, documents: [Document]?, notes: String?, itemID: String?) {
        self.type = type
        self.info = info
        self.documents = documents
        self.notes = notes
        self.itemID = itemID
    }
}
