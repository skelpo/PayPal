import Vapor

extension Invoice {
    
    /// The phases of an invoice in its lifecycle.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// A merchant creates a [draft invoice](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_create).
        ///
        /// - Note: A customer cannot pay an invoice with this status. A customer cannot pay an invoice until it has a status of `SENT` or `UNPAID`.
        case draft = "DRAFT"
        
        /// A merchant chooses to suppress the PayPal email notification when he or she sends the invoice through the
        /// [API](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_send) or the
        /// [Create Invoice](https://www.paypal.com/invoice/create) page, and then manually sends the invoice link in his or her own email.
        ///
        /// To send an invoice without email notification, the merchant either:
        /// - Sets the `notify_merchant` and `notify_customer` query parameters to `false` when he or she
        ///   [sends the invoice](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_send).
        /// - Selects **Share link myself** from the **Send** menu when he or she sends the invoice through the web UI
        ///   [Create Invoice](https://www.paypal.com/invoice/create) page.
        case unpaid = "UNPAID"
        
        /// A merchant accepts the default PayPal email notification when he or she sends the invoice through the
        /// [API](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_send) or the [Create Invoice](https://www.paypal.com/invoice/create) page.
        /// PayPal automatically emails the invoice to the customer and a **Pay** button appears on the invoice, which enables the customer to pay the invoice.
        /// In a web app, the invoice appears as `Unpaid (sent)`.
        case sent = "SENT"
        
        /// A merchant [schedules an invoice](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_schedule) to send on a future date.
        /// At 07:00 on that date in the preferred time zone of the merchant's PayPal account profile, PayPal emails an invoice notification
        /// to the merchant and the customer, adds an online payment button to the customer’s view of the invoice, and updates the invoice status to `SENT`.
        case scheduled = "SCHEDULED"
        
        /// A customer makes a partial payment for the invoice through one of these methods:
        /// - A customer makes a [disconnected partial payment](https://developer.paypal.com/docs/api/invoicing/v1/#disconnected) for the invoice and
        ///   the merchant manually [marks the invoice as paid](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_record-payment).
        /// - A customer makes a [connected partial payment](https://developer.paypal.com/docs/api/invoicing/v1/#connected) for the invoice.
        case partiallyPaid = "PARTIALLY_PAID"
        
        /// A customer pays an invoice but the payment is pending for one of these reasons:
        /// - The payment is an uncleared eCheck.
        /// - The merchant must either accept the payment before it clears or deny the payment.
        /// - PayPal risk is reviewing the payment.
        ///
        /// - Note: Most payments never go into a payment-pending state.
        case pending = "PAYMENT_PENDING"
        
        /// A customer fully pays the invoice through one of these methods:
        /// - A customer makes a [connected full payment](https://developer.paypal.com/docs/api/invoicing/v1/#connected) for the invoice.
        /// - A customer makes a [connected partial payment](https://developer.paypal.com/docs/api/invoicing/v1/#connected) for the invoice.
        ///   Then, the customer makes a [disconnected payment](https://developer.paypal.com/docs/api/invoicing/v1/#disconnected), such as a check payment,
        ///   to pay the balance of the invoice and the merchant manually marks the invoice as fully paid.
        case paid = "PAID"
        
        /// A customer makes a [disconnected payment](https://developer.paypal.com/docs/api/invoicing/v1/#disconnected) for the balance of the invoice.
        /// The merchant manually marks the invoice as paid.
        case markedPaid = "MARKED_AS_PAID"
        
        /// A merchant or customer [cancels a sent invoice](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_cancel).
        /// You can cancel an invoice in `SENT` or `UNPAID` status.
        case cancelled = "CANCELLED"
        
        /// A merchant fully refunds an invoice through one these methods:
        /// - A merchant makes a [connected full refund](https://developer.paypal.com/docs/api/invoicing/v1/#connected) for the invoice.
        /// - A merchant makes a [connected partial refund](https://developer.paypal.com/docs/api/invoicing/v1/#connected) for the invoice.
        ///   Then, the merchant makes a [disconnected refund](https://developer.paypal.com/docs/api/invoicing/v1/#disconnected),
        ///   such as a check payment, for the invoice balance and manually marks the invoice as fully refunded.
        case refunded = "REFUNDED"
        
        /// A merchant partially refunds an invoice through one or both of these methods:
        /// - A merchant makes a [disconnected partial refund](https://developer.paypal.com/docs/api/invoicing/v1/#disconnected),
        ///   such as a check payment, for the invoice and marks the invoice as partially refunded. To complete this action,
        ///   the merchant must previously [mark the invoice as paid](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_record-payment).
        /// - A merchant makes a [connected partial refund](https://developer.paypal.com/docs/api/invoicing/v1/#connected)
        ///  for a [connected partial payment](https://developer.paypal.com/docs/api/invoicing/v1/#connected).
        case partiallyRefunded = "PARTIALLY_REFUNDED"
        
        /// A merchant makes a [disconnected refund](https://developer.paypal.com/docs/api/invoicing/v1/#disconnected-refund),
        /// such as a check payment, for the invoice balance and manually marks the invoice as fully refunded.
        ///
        /// - Note: A merchant can only mark a [marked-as-paid invoice](https://developer.paypal.com/docs/api/invoicing/v1/#invoices_record-payment) as refunded.
        case markedRefunded = "MARKED_AS_REFUNDED"
    }
}
