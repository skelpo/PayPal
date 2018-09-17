import Vapor

extension Payee {
    public struct Metadata: Content, Equatable {
        public var email: String?
        public var phone: DisplayPhone?
        public var brand: String?
        
        public init(email: String?, phone: DisplayPhone?, brand: String?) {
            self.email = email
            self.phone = phone
            self.brand = brand
        }
    }
}
