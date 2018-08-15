import Vapor

public struct TemplateList: Content, Equatable {
    public let links: [LinkDescription]?
    
    public var addresses: [Address]?
    public var emails: [Email<EmailKeys>]?
    public var phones: [PhoneNumber]?
    public var templates: [Template]?
    
    public init(addresses: [Address]?, emails: [Email<EmailKeys>]?, phones: [PhoneNumber]?, templates: [Template]?) {
        self.links = nil
        self.addresses = addresses
        self.emails = emails
        self.phones = phones
        self.templates = templates
    }
}
