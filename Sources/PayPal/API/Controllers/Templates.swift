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
}
