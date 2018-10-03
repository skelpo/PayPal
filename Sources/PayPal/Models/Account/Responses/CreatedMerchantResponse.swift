import Vapor

/// The body of the response when a new merchant account is created.
public struct CreatedMerchantResponse: Content, ValidationSetable, Equatable {
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// The payer ID. If the account was not created, this value is blank.
    ///
    /// Maximum length: 127.
    public var payer: String?
    
    /// The partner-specified ID for the account, which was passed in the `partner_merchant_external_id` request parameter.
    ///
    /// Maximum length: 127.
    public var partnerExternalID: String?
    
    /// The merchant authorization code.
    public var authCode: String?
    
    /// An array of key-and-value pairs that contain custom data. For example, `aa_token`.
    public var custom: [KeyValue]?
    
    /// An array of errors, if any, that occurred during account creation.
    public var errors: [AccountError]?
    
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let payer = try container.decodeIfPresent(String.self, forKey: .payer)
        let partnerExternalID = try container.decodeIfPresent(String.self, forKey: .partnerExternalID)
        
        self.payer = payer
        self.partnerExternalID = partnerExternalID
        self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
        self.authCode = try container.decodeIfPresent(String.self, forKey: .authCode)
        self.custom = try container.decodeIfPresent([KeyValue].self, forKey: .custom)
        self.errors = try container.decodeIfPresent([AccountError].self, forKey: .errors)
        
        try self.set(\.payer <~ payer)
        try self.set(\.partnerExternalID <~ partnerExternalID)
    }
    
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<CreatedMerchantResponse> {
        var validations = SetterValidations(CreatedMerchantResponse.self)
        
        validations.set(\.payer) { payer in
            guard let payer = payer else { return }
            guard payer.count <= 127 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`payer` value length must be 127 or less")
            }
        }
        validations.set(\.partnerExternalID) { partnerExternalID in
            guard let partnerExternalID = partnerExternalID else { return }
            guard partnerExternalID.count <= 127 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`partnerExternalID` value length must be 127 or less")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case links, errors
        case payer = "payer_id"
        case partnerExternalID = "partner_merchant_external_id"
        case authCode = "merchant_authorization_code"
        case custom = "custom_data"
    }
}
