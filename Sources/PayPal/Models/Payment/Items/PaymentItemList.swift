import Vapor

extension Payment {
    public struct ItemList: Content, Equatable {
        public var items: [Item]?
        public var address: Address?
        public var phoneNumber: String?
        
        public init(items: [Item]?, address: Address?, phoneNumber: String?) {
            self.items = items
            self.address = address
            self.phoneNumber = phoneNumber
        }
    }
}
