import Vapor

/// The payment made during each cycle of a billing agreement.
public struct Payment: Content, ValidationSetable, Equatable {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The payment definition name.
    ///
    /// Maximum length: 128.
    public var name: String
    
    /// The payment definition type.
    public var type: PaymentType
    
    /// The interval at which the customer is charged.
    /// Value cannot be greater than 12 months.
    ///
    /// The coding key string value for this property is `frequency_interval`.
    public var interval: String
    
    /// The frequency of the payment in this definition.
    public var frequency: Frequency
    
    /// The number of payment cycles in this definition.
    /// For infinite plans with a regular payment definition, set `cycles` to `0`.
    public var cycles: String
    
    /// The currency and amount to charge at the end of each payment cycle for this definition.
    public var amount: Money
    
    /// An array of shipping fee and tax information for this definition.
    public var charges: [Charge]?
    
    /// Creatse a new `Payment` instance.
    ///
    ///     Payment(
    ///         name: "Service Membership",
    ///         type: .regular,
    ///         interval: "2",
    ///         frequency: .month,
    ///         cycles: "0",
    ///         amount: Money(currency: .usd, value: "24.99"),
    ///         charges: nil
    ///     )
    public init(name: String, type: PaymentType, interval: String, frequency: Frequency, cycles: String, amount: Money, charges: [Charge]?) {
        self.id = nil
        self.name = name
        self.type = type
        self.interval = interval
        self.frequency = frequency
        self.cycles = cycles
        self.amount = amount
        self.charges = charges
    }
    
    public func setterValidations() -> SetterValidations<Payment> {
        var validations = SetterValidations(Payment.self)
        
        validations.set(\.name) { name in
            guard name.count <= 128 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "The `name` property must have a length of 128 or less.")
            }
        }
        validations.set(\.interval) { interval in
            guard let int = Int(interval) else {
                throw PayPalError(status: .badRequest, identifier: "badType", reason: "`frequency_interval` must be convertible to a integer")
            }
            
            var error = false
            switch self.frequency {
            
            // Sure, this case doesn't handle leap years, but how would you do that anyway?
            // PRs are welcome if you happen to figure it out!
            case .day: guard int <= 365 else { error = true; break }
            case .week: guard int <= 52 else { error = true; break }
            case .month: guard int <= 12 else { error = true; break }
            case .year: guard int <= 1 else { error = true; break }
            }
            
            if error { throw PayPalError(status: .badRequest, identifier: "invalidFrequency", reason: "`frequency_interval` cannot be more the 12 monthes") }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, frequency, cycles, amount, charges
        case interval = "frequency_interval"
    }
}
