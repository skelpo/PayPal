import Vapor

internal let moneyValuePattern = "^((-?[0-9]+)|(-?([0-9]+)?[.][0-9]+))$"

public final class Money: Content {
    public private(set) var currencyCode: String
    public private(set) var value: String
    
    public init(currencyCode: String, value: String)throws {
        guard let _ = Currency.allKeyedCases[currencyCode.lowercased()] else {
            throw Abort(.badRequest, reason: "Attempted to use invalid currency code '\(currencyCode)'")
        }
        guard
            value.range(of: moneyValuePattern, options: .regularExpression, range: nil, locale: nil) != nil &&
            value.count <= 32
        else {
            throw Abort(.badRequest, reason: "Attempted to use malformed mony amount value '\(value)'")
        }
        
        self.currencyCode = currencyCode
        self.value = value
    }
    
    public func setValue(to value: String)throws {
        guard
            value.range(of: moneyValuePattern, options: .regularExpression, range: nil, locale: nil) != nil &&
                value.count <= 32
            else {
                throw Abort(.badRequest, reason: "Attempted to use malformed mony amount value '\(value)'")
        }
        self.value = value
    }
    
    public func setCode(to code: String)throws {
        guard let _ = Currency.allKeyedCases[currencyCode.lowercased()] else {
            throw Abort(.badRequest, reason: "Attempted to use invalid currency code '\(currencyCode)'")
        }
        self.currencyCode = code
    }
}
