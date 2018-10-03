import Vapor

extension Template {
    
    /// A template setting, describing whether a fields should be visible or hidden in an invoice.
    public struct Settings: Content, Equatable {
        
        /// The field name in `template_data` for which to map corresponding display preferences.
        public var field: Field?
        
        /// The template settings metadata.
        public var preference: Metadata?
        
        
        /// Creates a new `Template.Settings` instance.
        ///
        ///     Template.Settings(field: .itemDescription, preference: Metadata(hidden: false))
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
