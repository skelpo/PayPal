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

public struct Length50: StringLengthValidation { public static var maxLength: Int { return 50 } }
public struct Length120: StringLengthValidation { public static var maxLength: Int { return 120 } }
public struct Length127: StringLengthValidation { public static var maxLength: Int { return 127 } }
public struct Length128: StringLengthValidation { public static var maxLength: Int { return 128 } }
public struct Length255: StringLengthValidation { public static var maxLength: Int { return 255 } }
public struct Length256: StringLengthValidation { public static var maxLength: Int { return 256 } }
public struct Length300: StringLengthValidation { public static var maxLength: Int { return 300 } }
public struct Length2000: StringLengthValidation { public static var maxLength: Int { return 2_000 } }

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
    public static var min: Int? = 0
}

public struct YearRange: InRangeValidation {
    public typealias Supported = Int
    
    public static var max: Int? = 9_999
    public static var min: Int? = 1_000
}
