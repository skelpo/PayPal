import Vapor

public struct DisplayPhone: Content, Equatable {
    public var country: String?
    public var number: String?
    
    public init(country: String?, number: String?) {
        self.country = country
        self.number = number
    }
}
