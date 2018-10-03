import Vapor

/// Evidance for a party in a dispute.
public struct Evidence: Content, ValidationSetable, MultipartPartConvertible, Equatable {
    
    /// The type of evidence.
    public var type: EvidenceType?
    
    /// The evidence-related information.
    public var info: Info?
    
    /// An array of evidence documents.
    public var documents: [Document]?
    
    /// Any evidence-related notes.
    ///
    /// This property can be set using the `Evidence.set(_:)` method, which validates
    /// the new value before assigning it to the property.
    ///
    /// Maximum length: 2000.
    public private(set) var notes: String?
    
    /// The item ID. If the merchant provides multiple pieces of evidence and the transaction has multiple item IDs,
    /// the merchant can use this value to associate a piece of evidence with an item ID.
    public var itemID: String?
    
    
    /// Creates a new `Evidence` instance.
    ///
    ///     Evidence(
    ///         type: .proofOfFulfillment,
    ///         info: Info(
    ///             tracking: [
    ///                 Tracking(carrier: .usps, other: nil, url: "https://whoshippedit.com/shippment/9163524667210796186056", number: "9163524667210796186056")
    ///             ],
    ///             refunds: [
    ///                 "2F214F48-2651-498B-9D06-150BF00E85DA"
    ///             ]
    ///         ),
    ///         documents: [Document(name: "README.md", size: "65kb")],
    ///         notes: "I win. Ha!",
    ///         itemID: "4FB4018C-F925-4FC6-B44B-0174C1B59F17"
    ///     )
    public init(type: EvidenceType?, info: Info?, documents: [Document]?, notes: String?, itemID: String?)throws {
        self.type = type
        self.info = info
        self.documents = documents
        self.notes = notes
        self.itemID = itemID
        
        try self.set(\.notes <~ notes)
    }
    
    /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let notes = try container.decodeIfPresent(String.self, forKey: .notes)
        
        self.notes = notes
        self.type = try container.decodeIfPresent(EvidenceType.self, forKey: .type)
        self.info = try container.decodeIfPresent(Info.self, forKey: .info)
        self.documents = try container.decodeIfPresent([Document].self, forKey: .documents)
        self.itemID = try container.decodeIfPresent(String.self, forKey: .itemID)
        
        try self.set(\.notes <~ notes)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<Evidence> {
        var validations = SetterValidations(Evidence.self)
        
        validations.set(\.notes) { note in
            guard note?.count ?? 0 <= 2000 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`notes` property must have a length between 0 and 2000")
            }
        }
        
        return validations
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
