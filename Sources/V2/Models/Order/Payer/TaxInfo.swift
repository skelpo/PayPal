import Failable
import PayPal

/// The tax information for a payer, typically in an order.
public struct TaxInfo: Codable {
    
    /// The customer's tax ID. Supported for the PayPal payment method only. Typically,
    /// the tax ID is 11 characters long for individuals and 14 characters long for businesses.
    public let id: Failable<String, ID>
    
    /// The customer's tax ID type. Supported for the PayPal payment method only.
    public let type: TaxType
    
    /// Creates a new `TaxInfo` instance.
    ///
    /// - Parameters:
    ///   - id: The customer's tax ID.
    ///   - type: The customer's tax ID type.
    public init(id: Failable<String, ID>, type: TaxType) {
        self.id = id
        self.type = type
    }
    
    /// The validator for the `TaxInfo.id` property value.
    public struct ID: StringLengthValidation {
        
        /// See `StringLengthValidation.maxLength`.
        ///
        /// The maximum length of a string is 14 characters.
        public static let maxLength: Int = 14
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "tax_id"
        case type = "tax_id_type"
    }
}

/// The type of ID for a `TaxInfo` instance.
public enum TaxType: String, Hashable, CaseIterable, Codable {
    
    /// The individual tax ID type.
    case cff = "BR_CPF"
    
    /// The business tax ID type.
    case cnpj = "BR_CNPJ"
}
