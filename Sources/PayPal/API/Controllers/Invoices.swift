import Vapor

/// Use the `/invoices` resource to create, update, and send invoices and invoice reminders. To manage invoices, you can also list invoices,
/// show details for invoices, delete draft invoices, and cancel sent invoices. You can also mark invoices as fully or partially paid, or as refunded.
/// Lastly, you can create QR codes for invoices that can be scanned, viewed, and paid by a mobile phone.
public class Invoices: PayPalController {
    
    /// See `PayPalController.container`.
    public let container: Container
    
    /// Value is `"invoicing/invoices"`.
    ///
    /// See `PayPalController.resource` for more information.
    public let resource: String
    
    /// See `PayPalController.init(container:)`.
    public required init(container: Container) {
        self.container = container
        self.resource = "invoicing/invoices"
    }
}
