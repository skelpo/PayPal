import Countries
import Vapor

/// An identification document for a business owner.
public struct Identification: Content, Equatable {
    
    /// The type of document to use for identification.
    public var type: IDType
    
    /// The document number.
    public var value: String
    
    /// Indicates whether the value is a partial value. Use when the identifier type supports a partial value, such as a four-digit SSN number,
    /// instead of the full nine digits. This flag may not always be honored based on the context in which it is used.
    public var masked: Bool?
    
    /// The [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/)
    /// of the country that issued the identity document.
    public var issuerCountry: Country
    
    /// The [state or province code](https://developer.paypal.com/docs/integration/direct/rest/state-codes/)
    /// for the state or province that issued the identity document.
    public var issuerState: Province?
    
    /// The city that issued the identity document. Applies only to certain types of documents, such as `trade_registration_number` documents.
    public var issuerCity: String?
    
    /// The name of the place that issued the identity document. Applies only to some types, such as `TAX_ID` for Turkey (`TR`).
    public var placeOfIssue: String?
    
    /// A description of the entity that issued the identity document. For example, `registration authority`.
    public var description: String?
    
    
    /// Creates a new `BusinessOwner.ID` instance.
    ///
    /// - Parameters:
    ///   - type: The type of document to use for identification.
    ///   - value: The document number.
    ///   - masked: Indicates whether the value is a partial value.
    ///   - issuerCountry: The two-character IS0-3166-1 country code of the country that issued the identity document.
    ///   - issuerState: The state or province code for the state or province that issued the identity document.
    ///   - issuerCity: The city that issued the identity document.
    ///   - placeOfIssue: The name of the place that issued the identity document.
    ///   - description: A description of the entity that issued the identity document.
    public init(
        type: IDType,
        value: String,
        masked: Bool?,
        issuerCountry: Country,
        issuerState: Province?,
        issuerCity: String?,
        placeOfIssue: String?,
        description: String?
    ) {
        self.type = type
        self.value = value
        self.masked = masked
        self.issuerCountry = issuerCountry
        self.issuerState = issuerState
        self.issuerCity = issuerCity
        self.placeOfIssue = placeOfIssue
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {
        case type, value, masked
        case issuerCountry = "issuer_country_code"
        case issuerState = "issuer_state"
        case issuerCity = "issuer_city"
        case placeOfIssue = "place_of_issue"
        case description = "issuer_description"
    }
}
