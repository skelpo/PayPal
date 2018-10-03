import Vapor

/// Use the `/templates` resource to create, list, show details for, update, and delete invoice templates.
/// The template API is useful when creating a third-party invoicing application. For instance, a business can create a template with predefined invoice data.
/// Later, the business can select the template to populate the invoice data.
///
/// - Note: To upload a logo to display on an invoice, you can use the **Template Settings** dashboard to
///   [create a template](https://www.paypal.com/invoice/settings/templates). Then, use the URI of that logo when you create an invoice.
public final class Templates: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"invoicing/templates"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public init(container: Container) {
        self.container = container
        self.resource = "invoicing/templates"
    }
    
    
    /// Creates an invoice template. You can use details from this template to create an invoice. You can create up to 50 templates.
    ///
    /// - Note: Every merchant starts with three PayPal system templates that are optimized for the unit type billed.
    ///   The template includes `Quantity`, `Hours`, and `Amount`.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows template details.
    ///
    /// - Parameter template: The template data object sent to PayPal so a new Template can be created.
    ///
    /// - Returns: The saved template object wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func create(template: Template) -> Future<Template> {
        return Future.flatMap(on: self.container) { () -> Future<Template> in
            let client = try self.container.make(PayPalClient.self)
            return try client.post(self.path(), body: template, as: Template.self)
        }
    }
    
    /// Lists merchant-created templates with associated details. The associated details include the email addresses, postal addresses,
    /// and phone numbers from the user's PayPal profile.
    ///
    /// The user can select which values to show in the business information section of their template.
    /// 
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that lists invoices.
    ///
    /// - Parameter fields: The fields to return in the response. Value is `all` or `none`.
    ///   To return only the template name, ID, and default attributes, specify `none`.
    ///
    /// - Returns: The merchant's template details, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func list(fields: Template.ListFields = .all) -> Future<TemplateList> {
        return Future.flatMap(on: self.container) { () -> Future<TemplateList> in
            let client = try self.container.make(PayPalClient.self)
            let parameters = QueryParamaters(custom: ["fields": fields.rawValue])
            
            return try client.get(self.path(), parameters: parameters, as: TemplateList.self)
        }
    }
    
    /// Updates a template, by ID. In the JSON request body, specify a complete `Template` object. The update method does not support partial updates.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows template details.
    ///
    /// - Parameters:
    ///   - id: The ID of the template to update.
    ///   - data: The template object to replace the current template data with.
    ///
    /// - Returns: The updated `Template` object, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func update(template id: String, with data: Template) -> Future<Template> {
        return Future.flatMap(on: self.container) { () -> Future<Template> in
            let client = try self.container.make(PayPalClient.self)
            return try client.put(self.path() + id, body: data, as: Template.self)
        }
    }
    
    /// Deletes a template, by ID.
    ///
    /// A successful request returns the HTTP `204 No Content` status code with no JSON response body.
    ///
    /// - Parameter id: The ID of the template to delete.
    ///
    /// - Returns: The HTTP status of the response, which will be 204 (No Content), wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func delete(template id: String) -> Future<HTTPStatus> {
        return Future.flatMap(on: self.container) { () -> Future<HTTPStatus> in
            let client = try self.container.make(PayPalClient.self)
            return try client.delete(self.path() + id, as: HTTPStatus.self)
        }
    }
    
    /// Shows details for a template, by ID.
    ///
    /// A successful request returns the HTTP `200 OK` status code and a JSON response body that shows template details.
    ///
    /// - Parameter templateID: The ID of the template for which to show details.
    ///
    /// - Returns: The `Template` object for the ID passed in, wrapped in a future. If an error response was sent back instead,
    ///   it gets converted to a Swift error and the future wraps that instead.
    public func details(for templateID: String) -> Future<Template> {
        return Future.flatMap(on: self.container) { () -> Future<Template> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path() + templateID, as: Template.self)
        }
    }
}
