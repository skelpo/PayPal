import Vapor

/// The body of the response when a new merchant account is created.
public struct CreatedMerchantResponse: Content, Equatable {
    
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
}
