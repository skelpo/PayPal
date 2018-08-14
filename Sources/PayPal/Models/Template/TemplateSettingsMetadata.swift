import Vapor

extension Template.Settings {
    public struct Metadata: Content, Equatable {
        public var hidden: Bool?
        
        public init(hidden: Bool?) {
            self.hidden = hidden
        }
    }
}
