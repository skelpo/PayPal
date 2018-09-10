import Vapor

extension Business {
    public struct Designation: Content, Equatable {
        public var title: String?
        public var area: String?
        
        public init(title: String?, area: String?) {
            self.title = title
            self.area = area
        }
    }
}
