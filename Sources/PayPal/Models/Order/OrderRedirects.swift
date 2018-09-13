import Vapor

extension Order {
    public struct Redirects: Content, Equatable {
        public var `return`: String?
        public var cancel: String?
        
        public init(`return`: String?, cancel: String?) {
            self.return = `return`
            self.cancel = cancel
        }
    }
}
