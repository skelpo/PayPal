import Vapor

/// Evidance for a party in a dispute.
public struct Evidence: Content, ValidationSetable, Equatable {
    
    /// The type of evidence.
    public var type: EvidenceType?
    
    /// The evidence-related information.
    public var info: Info?
    
    /// An array of evidence documents.
    public var documents: [Document]?
    
    /// Any evidence-related notes.
    ///
    /// Maximum length: 2000.
    public var notes: String?
    
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
    public init(type: EvidenceType?, info: Info?, documents: [Document]?, notes: String?, itemID: String?) {
        self.type = type
        self.info = info
        self.documents = documents
        self.notes = notes
        self.itemID = itemID
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
}
