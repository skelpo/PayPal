import Vapor

/// The response returned from the `GET /v1/payments/payment` API endpoint.
public struct PaymentList: Content, ValidationSetable, Equatable {
    
    /// The ID of the element to use to get the next range of results.
    public let next: String?
    
    
    /// An array of payments.
    public var payments: [Payment]?
    
    /// The number of items returned in each range of results. Note that the last
    /// results range might have fewer items than the requested number of items.
    ///
    /// To set this propert, you can use the `PaymentList.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Maximum value: 20.
    public private(set) var count: Int?
    
    
    /// See `ValidationSetable.setterValidations`.
    public func setterValidations() -> SetterValidations<PaymentList> {
        var validations = SetterValidations(PaymentList.self)
        
        validations.set(\.count) { count in
            guard count ?? 0 <= 20 else {
                throw PayPalError(identifier: "badValue", reason: "`count` value must be in range 0 through 20")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case payments, count
        case next = "next_id"
    }
}
