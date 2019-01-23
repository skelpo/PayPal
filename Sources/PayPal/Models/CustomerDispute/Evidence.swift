import Vapor

/// Evidance for a party in a dispute.
public struct Evidence: Content, MultipartPartConvertible, Equatable {
    
    /// The type of evidence.
    public var type: EvidenceType?
    
    /// The evidence-related information.
    public var info: Info?
    
    /// An array of evidence documents.
    public var documents: [Document]?
    
    /// Any evidence-related notes.
    ///
    /// Maximum length: 2000.
    public var notes: Failable<String?, NotNilValidate<Length2000>>
    
    /// The item ID. If the merchant provides multiple pieces of evidence and the transaction has multiple item IDs,
    /// the merchant can use this value to associate a piece of evidence with an item ID.
    public var itemID: String?
    
    
    /// Creates a new `Evidence` instance.
    ///
    /// - Parameters:
    ///   - type: The type of evidence.
    ///   - info: The evidence-related information.
    ///   - documents: An array of evidence documents.
    ///   - notes: Any evidence-related notes.
    ///   - itemID: The item ID.
    public init(type: EvidenceType?, info: Info?, documents: [Document]?, notes: Failable<String?, NotNilValidate<Length2000>>, itemID: String?) {
        self.type = type
        self.info = info
        self.documents = documents
        self.notes = notes
        self.itemID = itemID
    }
    
    public func convertToMultipartPart() throws -> MultipartPart {
        let data = try JSONEncoder().encode(self)
        let type = MediaType.json.serialize()
        
        return MultipartPart(data: data, headers: ["Content-Type": type])
    }
    
    public static func convertFromMultipartPart(_ part: MultipartPart) throws -> Evidence {
        return try JSONDecoder().decode(Evidence.self, from: part.data)
    }
    
    enum CodingKeys: String, CodingKey {
        case notes, documents
        case type = "evidence_type"
        case info = "evidence_info"
        case itemID = "item_id"
    }
}
