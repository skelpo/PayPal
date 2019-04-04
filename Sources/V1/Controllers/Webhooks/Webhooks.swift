import PayPal
import Vapor

/// The PayPal REST APIs use [webhooks](https://developer.paypal.com/docs/integration/direct/webhooks) for event notification.
/// Webhooks are HTTP callbacks that receive notification messages for events. After you configure a webhook listener for your
/// app, you can [create a webhook](https://developer.paypal.com/docs/api/webhooks/v1/#webhooks_create), which subscribes
/// the webhook listener for your app to events. The `notifications` namespace contains resource collections for webhooks.
///
/// # Webhooks
///
/// Use the `/webhooks` resource to create, show details for, list all, update, and delete webhooks.
///
/// # Verify Webhook Signature
///
/// Use the `/verify-webhook-signature` resource to verify a webhook signature.
///
/// # Event Type
///
/// Use the `/webhooks-event-types` resource to list events to which webhooks can subscribe and the
/// `/webhooks/<webhook_id>/event-types` resource to list event subscriptions for a webhook.
public final class Webhooks: VersionedController {
    
    /// See `VersionedController.client`
    public let client: PayPalClient
    
    /// See `VersionedController.resource`.
    public let resource: [String]
    
    /// The controller for the `/notifications/verify-webhook-signature` resource.
    public var verification: Verification {
        return Verification(client: self.client)
    }
    
    /// The controller for the `/notifications/webhooks-event-types` resource.
    public var eventTypes: EventTypes {
        return EventTypes(client: self.client)
    }
    
    /// The controller for the `/notifications/webhooks-events` resource.
    public var events: Events {
        return Events(client: self.client)
    }
    
    /// See `VersionedController.init(client:)`.
    public init(client: PayPalClient) {
        self.client = client
        self.resource = ["notifications", "webhooks"]
    }
    
    /// Subscribes your webhook listener to events.
    ///
    /// A successful request returns the HTTP 201 Created status code and a JSON response body with a
    /// `Webhook` object that includes the webhook ID for later use.
    ///
    /// - Parameter webhook: The `Webhook` instance to create
    public func create(webhook: Webhook) -> EventLoopFuture<Webhook> {
        return self.client.post(self.path, body: webhook, as: Webhook.self)
    }
    
    /// Lists all webhooks for an app.
    ///
    /// A successful request returns the HTTP 200 OK status code and a JSON response body that lists
    /// webhooks with webhook details.
    ///
    /// - Parameter anchor: Filters the webhooks in the response by the `anchor_id` entity type.
    /// - Returns: The webhooks that match the given `anchor` value, wrapped in an `EventLoopFuture`.
    public func get(by anchor: Webhook.AnchorType = .application) -> EventLoopFuture<[Webhook]> {
        let parameters = QueryParamaters(custom: ["anchor_type": anchor.rawValue])
        return self.client.get(self.path, parameters: parameters, as: [Webhook].self)
    }
    
    /// Deletes a webhook, by ID.
    ///
    /// A successful request returns the HTTP 204 No Content status code with no JSON response body.
    ///
    /// - Parameter webhook: The ID of the webhook to delete.
    /// - Returns: A void `EventLoopFuture` that succeedes when the delete completes.
    public func delete(webhook: String) -> EventLoopFuture<Void> {
        return self.client.delete(self.path + webhook, as: HTTPStatus.self).transform(to: ())
    }
    
    /// Replaces webhook fields with new values. Supports only the `replace` operation. Pass a `json_patch` object with
    /// `replace` operation and `path`, which is `/url` for a URL or `/event_types` for events. The `value` is either
    /// the URL or a list of events.
    ///
    /// A successful request returns the HTTP 200 OK status code and a JSON response body that shows webhook details.
    ///
    /// - Parameters:
    ///   - webhook: The ID of the webhook to update.
    ///   - patches: An array of JSON patch objects to apply partial updates to resources.
    ///
    /// - Returns: The updated `Webhook` object, wrapped in an `EventLoopFuture`.
    public func update(webhook: String, with patches: [Patch]) -> EventLoopFuture<Webhook> {
        return self.client.patch(self.path + webhook, body: patches, as: Webhook.self)
    }
    
    /// Shows details for a webhook, by ID.
    ///
    /// A successful request returns the HTTP 200 OK status code and a JSON response body that shows webhook details
    ///
    /// - Parameter webhook: The ID of the webhook for which to show details.
    /// - Returns: The `Webhook` object for the given ID, wrapped in an `EventLoopFuture`.
    public func get(webhook: String) -> EventLoopFuture<Webhook> {
        return self.client.get(self.path + webhook, as: Webhook.self)
    }
    
    /// Lists event subscriptions for a webhook, by ID.
    ///
    /// A successful request returns the HTTP 200 OK status code and a JSON response body that lists event
    /// subscriptions for a webhook.
    ///
    /// - Parameter webhook: The ID of the webhook for which to list subscriptions.
    /// - Returns: The list of `EventType` objects for the webhook, wrapped in an `EventLoopFuture`.
    public func eventTypes(for webhook: String) -> EventLoopFuture<[EventType]> {
        return self.client.get(self.path + webhook + "/event-types", as: [EventType].self)
    }
}
