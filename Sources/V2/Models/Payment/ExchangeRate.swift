import Foundation
import PayPal

/// Defines a relationship between two different currencies, where the value is equal to 1 unit of the source currency.
///
/// If you where going to represent the exchange rate between `USD` and `EUR`, it might look like this:
///
///     // Rate from Mar 28, 2019, 3:48 PM UTC
///     ExchangeRate(source: .usd, target: .eur, value: 0.89)
public struct ExchangeRate: Codable {
    
    /// The source currency from which to convert an amount.
    public let source: Currency?
    
    /// The target currency into which to convert an amount.
    public let target: Currency?
    
    /// The target currency amount. Equivalent to one unit of the source currency.
    /// Formatted as integer or decimal value with one to 15 digits to the right of the decimal point.
    public let value: Decimal?
    
    /// Creates a new `ExchangeRate` instance.
    ///
    /// - Parameters:
    ///   - source: The source currency from which to convert an amount.
    ///   - target: The target currency into which to convert an amount.
    ///   - value: The target currency amount.
    public init(source: Currency?, target: Currency?, value: Decimal?) {
        self.source = source
        self.target = target
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case source = "source_currency"
        case target = "target_currency"
        case value
    }
}
