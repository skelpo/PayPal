import Vapor

/// The payment made during each cycle of a billing agreement.
public struct BillingPayment<M>: Content, Equatable where M: Amount {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The payment definition name.
    ///
    /// Maximum length: 128.
    public var name: Failable<String, Length128>
    
    /// The payment definition type.
    public var type: PaymentType
    
    /// The interval at which the customer is charged.
    /// Value cannot be greater than 12 months.
    ///
    /// The coding key string value for this property is `frequency_interval`.
    public var interval: Int
    
    /// The frequency of the payment in this definition.
    public var frequency: Frequency
    
    /// The number of payment cycles in this definition.
    /// For infinite plans with a regular payment definition, set `cycles` to `0`.
    public var cycles: Int
    
    /// The currency and amount to charge at the end of each payment cycle for this definition.
    public var amount: M
    
    /// An array of shipping fee and tax information for this definition.
    public var charges: [Charge]?
    
    /// Creatse a new `BillingPayment` instance.
    ///
    /// - Parameters:
    ///   - name:
    ///   - type"
    ///   - interval:
    ///   - frequency:
    ///   - cycles:
    ///   - amount:
    ///   - charges:
    public init(
        name: Failable<String, Length128>,
        type: PaymentType,
        interval: Int,
        frequency: Frequency,
        cycles: Int,
        amount: M,
        charges: [Charge]?
    ) {
        self.id = nil
        self.name = name
        self.type = type
        self.interval = interval
        self.frequency = frequency
        self.cycles = cycles
        self.amount = amount
        self.charges = charges
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let interStr = try container.decode(String.self, forKey: .interval)
        let cycStr = try container.decode(String.self, forKey: .cycles)
        
        guard let interval = Int(interStr) else {
            throw DecodingError.dataCorruptedError(forKey: .interval, in: container, debugDescription: "Value must be convertible to int")
        }
        guard let cycles = Int(cycStr) else {
            throw DecodingError.dataCorruptedError(forKey: .cycles, in: container, debugDescription: "Value must be convertible to int")
        }
        
        self.interval = interval
        self.cycles = cycles
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decode(Failable<String, Length128>.self, forKey: .name)
        self.type = try container.decode(PaymentType.self, forKey: .type)
        self.frequency = try container.decode(Frequency.self, forKey: .frequency)
        self.amount = try container.decode(M.self, forKey: .amount)
        self.charges = try container.decodeIfPresent([Charge].self, forKey: .charges)
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to enccoder: Encoder)throws {
        var container = enccoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.charges, forKey: .charges)
        try container.encode(String(self.interval), forKey: .interval)
        try container.encode(String(self.cycles), forKey: .cycles)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.frequency, forKey: .frequency)
        try container.encode(self.amount, forKey: .amount)
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, frequency, cycles, amount, charges
        case interval = "frequency_interval"
    }
}
