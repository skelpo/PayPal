@_exported import Failable

public struct Length127<C>: LengthValidation where C: Collection {
    public typealias Supported = C
    
    public static var maxLength: Int { return 127 }
    public static var minLength: Int { return 0 }
}
