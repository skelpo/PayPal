import Vapor

extension Template {
    
    /// The options of which fields to return of the templates when fetching the list of templates.
    public enum ListFields: String, Hashable, CaseIterable, Content {
        
        /// `none`
        ///
        /// Returns only the template name, ID, and default attributes.
        case none
        
        /// `all`
        case all
    }
}
