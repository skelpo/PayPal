import Vapor

extension Template.Settings {
    
    /// Additional metadata for a `Template.Settings. object.
    public struct Metadata: Content, Equatable {
        
        /// Indicates whether to show or hide this field.
        public var hidden: Bool?
        
        /// Creates a new `Template.Settings.Metadata` instance.
        ///
        ///     Template.Settings.Metadata(hidden: true)
        public init(hidden: Bool?) {
            self.hidden = hidden
        }
    }
}
