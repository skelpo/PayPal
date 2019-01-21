@_exported import Failable

// MARK: - Collection Length

public typealias Optional127String = Failable<String?, NotNilValidate<Length127>>
public typealias Optional128String = Failable<String?, NotNilValidate<Length128>>
public typealias Optional300String = Failable<String?, NotNilValidate<Length300>>
public typealias Optional2000String = Failable<String?, NotNilValidate<Length1To2000>>

public protocol StringLengthValidation: Validation where Supported == String {
    static var maxLength: Int { get }
}

extension StringLengthValidation {
    public static func validate(_ value: String)throws {
        guard value.count <= self.maxLength else {
            throw ValidationError(identifier: "lengthTooLong", reason: "Length of string value is greater than \(self.maxLength)")
        }
    }
}

public struct Length14: StringLengthValidation { public static var maxLength: Int { return 14 } }
public struct Length22: StringLengthValidation { public static var maxLength: Int { return 22 } }
public struct Length25: StringLengthValidation { public static var maxLength: Int { return 25 } }
public struct Length30: StringLengthValidation { public static var maxLength: Int { return 30 } }
public struct Length40: StringLengthValidation { public static var maxLength: Int { return 40 } }
public struct Length50: StringLengthValidation { public static var maxLength: Int { return 50 } }
public struct Length60: StringLengthValidation { public static var maxLength: Int { return 60 } }

public struct Length100: StringLengthValidation { public static var maxLength: Int { return 100 } }
public struct Length120: StringLengthValidation { public static var maxLength: Int { return 120 } }
public struct Length127: StringLengthValidation { public static var maxLength: Int { return 127 } }
public struct Length128: StringLengthValidation { public static var maxLength: Int { return 128 } }
public struct Length140: StringLengthValidation { public static var maxLength: Int { return 140 } }
public struct Length150: StringLengthValidation { public static var maxLength: Int { return 150 } }
public struct Length165: StringLengthValidation { public static var maxLength: Int { return 165 } }

public struct Length200: StringLengthValidation { public static var maxLength: Int { return 200 } }
public struct Length255: StringLengthValidation { public static var maxLength: Int { return 255 } }
public struct Length256: StringLengthValidation { public static var maxLength: Int { return 256 } }
public struct Length260: StringLengthValidation { public static var maxLength: Int { return 260 } }

public struct Length300: StringLengthValidation { public static var maxLength: Int { return 300 } }
public struct Length480: StringLengthValidation { public static var maxLength: Int { return 480 } }
public struct Length500: StringLengthValidation { public static var maxLength: Int { return 500 } }

public struct Length1000: StringLengthValidation { public static var maxLength: Int { return 1_000 } }
public struct Length2000: StringLengthValidation { public static var maxLength: Int { return 2_000 } }
public struct Length2048: StringLengthValidation { public static var maxLength: Int { return 2_048 } }
public struct Length4000: StringLengthValidation { public static var maxLength: Int { return 4_000 } }

public struct Count4<C>: LengthValidation where C: Collection {
    public typealias Supported = C
    public static var maxLength: Int { return 4 }
    public static var minLength: Int { return 4 }
}

public struct Length1To2000: LengthValidation {
    public typealias Supported = String
    
    public static var maxLength: Int = 2_000
    public static var minLength: Int = 1
}

// MARK: - String Regex

public struct LocaleString: RegexValidation {
    public static var pattern: String = "^[a-z]{2}(?:-[A-Z][a-z]{3})?(?:-(?:[A-Z]{2}))?$"
}

public struct EmailString: RegexValidation {
    public static var pattern: String = "^(?=.{3,254}$).+@[^\"\\-].+$"
}


// MARK: - Dates

public struct MonthRange: InRangeValidation {
    public typealias Supported = Int
    
    public static var max: Int? = 12
    public static var min: Int? = 1
}

public struct YearRange: InRangeValidation {
    public typealias Supported = Int
    
    public static var max: Int? = 9_999
    public static var min: Int? = 1_000
}

// MARK: - Numerics

public struct TenThousand<C>: InRangeValidation where C: Comparable & ExpressibleByFloatLiteral {
    public typealias Supported = C
    
    public static var max: C? { return 10_000.00 }
    public static var min: C? { return -10_000.00 }
}

public struct TenDigits<C>: InRangeValidation where C: Comparable & ExpressibleByIntegerLiteral {
    public typealias Supported = C
    
    public static var max: C? { return 1_000_000_000 }
    public static var min: C? { return 0 }
}

// MARK: Currency

public struct CurrencyMillion<Key>: Validation where Key: AmountCodingKey {
    public static func validate(_ value: AmountType<Key>)throws {
        guard value.value <= 1_000_000 else {
            throw ValidationError(identifier: "valueTooGreat", reason: "Value passed in is greater than 1,000,000")
        }
        guard value.value >= -1_000_000 else {
            throw ValidationError(identifier: "valueTooSmall", reason: "Value passed in is less than -1,000,000")
        }
    }
}
