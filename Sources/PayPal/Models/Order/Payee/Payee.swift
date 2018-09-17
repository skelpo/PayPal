import Vapor

public struct Payee: Content, Equatable {
    public var email: String?
    public var merchant: String?
    public var metadata: Metadata?
    
    public init(email: String?, merchant: String?, metadata: Metadata?) {
        self.email = email
        self.merchant = merchant
        self.metadata = metadata
    }
}
