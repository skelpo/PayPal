import Foundation
import PayPal

/// And order object from PayPal.
public struct Order: Codable {
    
    /// The intent to either capture payment immediately or authorize a payment for an order after order creation.
    public var intent: Intent?
    
    /// The customer who approves and pays for the order. The customer is also known as the payer.
    public var payer: Payer?
    
    /// An array of purchase units. Each purchase unit establishes a contract between a customer and merchant.
    /// Each purchase unit represents either a full or partial order that the customer intends to purchase from the merchant.
    public var purchaseUnits: [PurchaseUnit]?
    
    /// The date and time when the transaction occurred.
    public let created: Date?
    
    /// The date and time when the transaction was last updated.
    public let updated: Date?
    
    /// The ID of the order.
    public let id: String?
    
    /// The order status.
    public let status: Status?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    /// To complete payer approval, use the `approve` link with the `GET` method.
    public let links: [LinkDescription]?
    
    /// Creates a new `Order` instance.
    ///
    /// - Parameters:
    ///   - intent: The intent to either capture payment immediately or authorize a payment for an order after order creation.
    ///   - payer: The customer who approves and pays for the order. The customer is also known as the payer.
    ///   - purchaseUnits: An array of purchase units. Each purchase unit establishes a contract between a customer and
    ///     merchant. Each purchase unit represents either a full or partial order that the customer intends to purchase
    ///     from the merchant.
    public init(intent: Intent?, payer: Payer?, purchaseUnits: [PurchaseUnit]?) {
        self.intent = intent
        self.payer = payer
        self.purchaseUnits = purchaseUnits
        
        self.created = nil
        self.updated = nil
        self.id = nil
        self.status = nil
        self.links = nil
    }
    
    /// The request structure to create a new `Order`.
    public struct Request: Codable {
        
        /// The intent to either capture payment immediately or authorize a payment for an order after order creation.
        public var intent: Intent
        
        /// The customer who approves and pays for the order. The customer is also known as the payer.
        public var payer: Payer?
        
        /// An array of purchase units. At present only 1 purchase_unit is supported. Each purchase unit establishes a
        /// contract between a payer and the payee. Each purchase unit represents either a full or partial order that
        /// the payer intends to purchase from the payee.
        public var purchaseUnits: [PurchaseUnit]
        
        /// Customize the payer experience during the approval process for the payment with PayPal.
        public var context: AppContext?
        
        /// Creates a new `Order.Request` instance.
        ///
        /// - Parameters:
        ///   - intent: The intent to either capture payment immediately or
        ///     authorize a payment for an order after order creation.
        ///   - payer: The customer who approves and pays for the order.
        ///   - purchaseUnits: An array of purchase units.
        ///   - context: Customize the payer experience during the approval process for the payment with PayPal.
        public init (intent: Intent, payer: Payer?, purchaseUnits: [PurchaseUnit], context: AppContext?) {
            self.intent = intent
            self.payer = payer
            self.purchaseUnits = purchaseUnits
            self.context = context
        }
        
        enum CodingKeys: String, CodingKey {
            case intent, payer
            case purchaseUnits = "purchase_units"
            case context = "application_context"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case intent, payer, id, status, links
        case purchaseUnits = "purchase_units"
        case created = "create_time"
        case updated = "update_time"
    }
}

extension Order {
    
    /// The intent to either capture payment immediately or authorize a payment for an order after order creation.
    public enum Intent: String, Codable, Hashable, CaseIterable {
        
        /// The merchant intends to capture payment immediately after the customer makes a payment.
        case capture = "CAPTURE"
        
        /// The merchant intends to authorize a payment and place funds on hold after the customer makes a payment.
        /// Authorized payments are guaranteed for up to three days but are available to capture for up to 29 days.
        /// After the three-day honor period, the original authorized payment expires and you must re-authorize the payment.
        /// You must make a separate request to capture payments on demand.
        case authorize = "AUTHORIZE"
    }
}
