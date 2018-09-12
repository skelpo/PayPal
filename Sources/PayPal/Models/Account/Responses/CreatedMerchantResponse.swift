import Vapor

public struct CreatedMerchantResponse: Content, Equatable {
    public let links: [LinkDescription]?
    
    public var payer: String?
    public var partnerExternalID: String?
    public var authCode: String?
    public var custom: [KeyValue]?
    public var errors: [AccountError]?
    
    public init(payer: String?, partnerExternalID: String?, authCode: String?, custom: [KeyValue]?, errors: [AccountError]?) {
        self.links = nil
        self.payer = payer
        self.partnerExternalID = partnerExternalID
        self.authCode = authCode
        self.custom = custom
        self.errors = errors
    }
}
