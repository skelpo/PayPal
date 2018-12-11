@_exported import Failable

// MARK: - Collection Length

public typealias Optional127String = Failable<String?, NotNilValidate<Length127>>
public typealias Optional128String = Failable<String?, NotNilValidate<Length128>>
public typealias Optional300String = Failable<String?, NotNilValidate<Length300>>

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

public struct Length120: StringLengthValidation { public static var maxLength: Int { return 120 } }
public struct Length127: StringLengthValidation { public static var maxLength: Int { return 127 } }
public struct Length128: StringLengthValidation { public static var maxLength: Int { return 128 } }
public struct Length300: StringLengthValidation { public static var maxLength: Int { return 300 } }

public struct Count4<C>: LengthValidation where C: Collection {
    public typealias Supported = C
    public static var maxLength: Int { return 4 }
    public static var minLength: Int { return 4 }
}

// MARK: - String Regex

public struct LocaleString: RegexValidation {
    public static var pattern: String = "^[a-z]{2}(?:-[A-Z][a-z]{3})?(?:-(?:[A-Z]{2}))?$"
}

public struct EmailString: RegexValidation {
    public static var pattern: String = "^(?=.{3,254}$).+@[^\"\\-].+$"
}


