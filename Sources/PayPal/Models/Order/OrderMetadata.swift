import Vapor

extension Order {
    public struct Metadata: Content, Equatable {
        public var data: [NameValue]?
        
        public init(data: [NameValue]?) {
            self.data = data
        }
    }
}
