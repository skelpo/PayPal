import Vapor

/// Tax information for a transaction.
public struct Tax: Content, ValidationSetable, Equatable {
    
    /// The tax name.
    ///
    /// This property can be set using the `Tax.set(_:)` method. This
    /// method will validate the new value before assigning it to the property.
    ///
    /// Maximum length: 100.
    public private(set) var name: String
    
    /// The tax rate. Value is from `0` to `100`. Supports up to five decimal places.
    ///
    /// This property can be set using the `Tax.set(_:)` method. This
    /// method will validate the new value before assigning it to the property.
    ///
    /// Minimum value: 0.
    public private(set) var percent: Decimal
    
    /// The currency and amount of the calculated tax.
    public let amount: Amount?
    
    
    /// Creates a new `Tax` instance.
    ///
    ///     Tax(name: "Sales", percent: 10, amount: Amount(code: .usd, value: "0.59"))
    public init(name: String, percent: Decimal, amount: Amount?) {
        self.name = name
        self.percent = percent
        self.amount = amount
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<Tax> {
        var validations = SetterValidations(Tax.self)
        
        validations.set(\.name) { name in
            guard name.count <= 100 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`name` property must have a length between 0 and 100")
            }
        }
        validations.set(\.percent) { percent in
            guard percent >= 0 && percent <= 100 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`percent` property must have a value between 0 and 100")
            }
        }
        
        return validations
    }
}
