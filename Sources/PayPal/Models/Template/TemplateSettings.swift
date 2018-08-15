import Vapor

extension Template {
    public struct Settings: Content, Equatable {
        public var field: Field?
        public var preference: Metadata?
        
        public init(field: Field?, preference: Metadata?) {
            self.field = field
            self.preference = preference
        }
        
        enum CodingKeys: String, CodingKey {
            case field = "field_name"
            case preference = "display_preference"
        }
    }
}
