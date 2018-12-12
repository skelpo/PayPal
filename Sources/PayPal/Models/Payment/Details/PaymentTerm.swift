import Vapor

/// The due data and terms of a payment.
public struct PaymentTerm: Content, Equatable {
    
    /// The term when the invoice payment is due.
    public var type: TermType?
    
    /// The date when the invoice payment is due, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// For example, _yyyy-MM-dd z_.
    public var due: Date?
    
    /// Creates a new `PaymentType` instance.
    ///
    /// - Parameters:
    ///   - type: The term when the invoice payment is due.
    ///   - due: The date when the invoice payment is due, in Internet date and time format.
    public init(type: TermType?, due: Date?) {
        self.type = type
        self.due = due
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dueStr = try container.decode(String.self, forKey: .due)
        guard let due = BusinessOwner.birthdateFormatter.date(from: dueStr) else {
            throw DecodingError.dataCorruptedError(forKey: .due, in: container, debugDescription: "Date format must be `yyyy-MM-dd`")
        }
        
        self.due = due
        self.type = try container.decode(TermType.self, forKey: .type)
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder)throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.type, forKey: .type)
        
        if let due = self.due {
            try container.encode(BusinessOwner.birthdateFormatter.string(from: due), forKey: .due)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type = "term_type"
        case due = "due_date"
    }
}

extension PaymentTerm {
    
    /// The term in which the invoice is due.
    public enum TermType: String, Hashable, CaseIterable, Content {
        
        /// `DUE_ON_RECEIPT`
        case dueOnReceipt = "DUE_ON_RECEIPT"
        
        /// `DUE_ON_DATE_SPECIFIED`
        case dueDate = "DUE_ON_DATE_SPECIFIED"
        
        /// `NET_10`
        case net10 = "NET_10"
        
        /// `NET_15`
        case net15 = "NET_15"
        
        /// `NET_30`
        case net30 = "NET_30"
        
        /// `NET_45`
        case net45 = "NET_45"
        
        /// `NET_60`
        case net60 = "NET_60"
        
        /// `NET_90`
        case net90 = "NET_90"
        
        /// `NO_DUE_DATE`
        case noDueDate = "NO_DUE_DATE"
    }
}
