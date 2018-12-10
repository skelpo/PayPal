@_exported import Failable

// MARK: - Collection Length

public typealias Optional127String = Failable<String?, NotNilValidate<Length127<String>>>
public typealias Optional128String = Failable<String?, NotNilValidate<Length128<String>>>

public struct Length127<C>: LengthValidation where C: Collection {
    public typealias Supported = C
    
    public static var maxLength: Int { return 127 }
    public static var minLength: Int { return 0 }
}

public struct Length128<C>: LengthValidation where C: Collection {
    public typealias Supported = C
    
    public static var maxLength: Int { return 128 }
    public static var minLength: Int { return 0 }
}


// MARK: - String Regex

public struct LocaleString: RegexValidation {
    public static var pattern: String = "^[a-z]{2}(?:-[A-Z][a-z]{3})?(?:-(?:[A-Z]{2}))?$"
}
