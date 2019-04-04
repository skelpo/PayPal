import PayPal
import Vapor

extension Webhooks {
    
    /// The controller for the `/webhooks-events` resource of the Webhooks PayPal API.
    public final class Events: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["notifications", "webhooks-events"]
        }
        
        /// Lists webhook event notifications. Use query parameters to filter the response.
        ///
        /// A successful request returns the HTTP 200 OK status code and a JSON response body that
        /// lists webhook event notifications.
        ///
        /// - Parameters:
        ///   - parameters:
        ///   - transaction: Filters the response to a single transaction, by ID.
        ///   - type: Filters the response to a single event.
        ///
        /// - Returns: The list of `Event` objects, along with count and related links.
        public func list(
            parameters: QueryParamaters = QueryParamaters(),
            transaction: String? = nil,
            type: String? = nil
        ) -> EventLoopFuture<Event.List> {
            var parameters = parameters
            if let transaction = transaction {
                parameters.custom?["transaction_id"] = transaction
            }
            if let eventType = type {
                parameters.custom?["event_type"] = eventType
            }
            
            return self.client.get(self.path, parameters: parameters, as: Event.List.self)
        }
    }
}

