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
}
