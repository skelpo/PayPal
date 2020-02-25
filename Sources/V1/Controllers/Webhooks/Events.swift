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
        
        /// Shows details for a webhook event notification, by ID.
        ///
        /// A successful request returns the HTTP 200 OK status code and a JSON response body that
        /// shows webhook event notification details
        ///
        /// - Parameter event: The ID of the webhook event notification for which to show details.
        /// - Returns: The `Event` object for the given ID, wrapped in an `EventLoopFuture`.
        public func get(event: String) -> EventLoopFuture<Event> {
            return self.client.get(self.path + event, as: Event.self)
        }
        
        /// Resends a webhook event notification, by ID. Any pending notifications are not resent.
        ///
        /// A successful request returns the HTTP 202 Accepted status code and a JSON response body
        /// that shows webhook event notification details.
        ///
        /// - Parameters:
        ///   - event: The ID of the webhook event notification to resend.
        ///   - ids: An array of webhook account IDs.
        ///
        /// - Returns: The `Event` object for the event that was resent, wrapped in an `EventLoopFuture`.
        public func resend(event: String, ids: [String]) -> EventLoopFuture<Event> {
            return self.client.post(self.path + event, body: ["webhook_ids": ids], as: Event.self)
        }
    }
}

