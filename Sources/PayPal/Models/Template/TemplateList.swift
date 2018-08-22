import Vapor

/// The list of templates returned from the `GET /v1/invoicing/templates` PayPal endpoint.
public struct TemplateList: Content, Equatable {
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// An array of postal addresses in the user's PayPal profile.
    public var addresses: [Address]?
    
    /// An array of email addresses in the user's PayPal profile.
    public var emails: [Email]?
    
    /// An array of phone numbers in the user's PayPal profile.
    public var phones: [PhoneNumber]?
    
    /// The details for each template. If `fields` is `none`, returns only the template name, ID, and default status.
    public var templates: [Template]?
    
    
    /// Creates a new `TemplateList` instance.
    ///
    /// Instead of creating a `TemplateList` with this initializer, you will most likely want to create it
    /// be decoding it from a JSON response from the PayPal API.
    public init(addresses: [Address]?, emails: [Email]?, phones: [PhoneNumber]?, templates: [Template]?) {
        self.links = nil
        self.addresses = addresses
        self.emails = emails
        self.phones = phones
        self.templates = templates
    }
}
