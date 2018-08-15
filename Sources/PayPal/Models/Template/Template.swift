import Vapor

public struct Template: Content, Equatable {
    
    /// The ID of the template.
    public let id: String?
    
    /// Indicates whether this template is a merchant-created custom template. The system generates non-custom templates.
    public let custom: Bool?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// The template name.
    ///
    /// - Note: The template name must be unique.
    public var name: String?
    
    /// Indicates whether this template is the default merchant template. A merchant can have one default template.
    public var `default`: Bool?
    
    /// The template data.
    public var data: Data?
    
    /// An array of template settings that describe which fields to show or hide when creating an invoice.
    public var settings: [Settings]?
    
    /// The unit of measure for the template.
    public var measureUnit: Invoice.Measure?
    
    
    /// Creates a new `Template` instance.
    ///
    ///     Template(
    ///         name: "Hours Template",
    ///         default: true,
    ///         data: nil,
    ///         settings: [
    ///             .init(field: .itemsDate, preference: Metadata(hidden: true)),
    ///             .init(field: .custom, preference: Metadata(hidden: true))
    ///         ],
    ///         measureUnit: .hours
    ///     )
    public init(name: String?, default: Bool?, data: Data?, settings: [Settings]?, measureUnit: Invoice.Measure?) {
        self.id = nil
        self.custom = nil
        self.links = nil
        
        self.name = name
        self.default = `default`
        self.data = data
        self.settings = settings
        self.measureUnit = measureUnit
    }
    
    
    enum CodingKeys: String, CodingKey {
        case name, `default`, settings, custom, links
        case id = "template_id"
        case data = "temaplate_data"
        case measureUnit = "unit_of_measure"
    }
}
