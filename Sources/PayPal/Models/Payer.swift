import Vapor

public struct Payer: Content, Equatable {
    public let id: String?
    public let firstName: String?
    public let lastName: String?
    public var email: String?
    public var shippingAddress: ShippingAddress?
    public var billingAddress: ShippingAddress?
    
    public init(email: String?, shippingAddress: ShippingAddress?, billingAddress: ShippingAddress?) {
        self.id = nil
        self.firstName = nil
        self.lastName = nil
        
        self.email = email
        self.shippingAddress = shippingAddress
        self.billingAddress = billingAddress
    }
}
