import Vapor

extension Order {
    
    /// The status of an order. After the customer approves the order, the status is `APPROVED`.
    /// After the payment is made for the order and the order completes, the status is `COMPLETED`. 
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The `POST /v1/checkout/orders` call succeeded and the order was created.
        case created = "CREATED"
        
        /// The customer approved the order.
        case approved = "APPROVED"
        
        /// The `POST /v1/checkout/orders/{order_id}/pay` call succeeded and the order was paid and is complete.
        case completed = "COMPLETED"
        
        /// The order failed.
        case failed = "FAILED"
    }
}
