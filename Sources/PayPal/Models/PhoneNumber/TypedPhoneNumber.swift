import Vapor

public struct TypedPhoneNumber: Content, Equatable {
    public var type: PhoneType
    public var country: String
    public var nationalNumber: String
    public var `extension`: String?
    
    public init(type: PhoneType, country: String, nationalNumber: String, `extension`: String?) {
        self.type = type
        self.country = country
        self.nationalNumber = nationalNumber
        self.extension = `extension`
    }
}
