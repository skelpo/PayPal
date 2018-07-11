import Vapor

/// An interface for the PayPal Activities API.
///
/// Activities are records for all payments, currency transfers,
/// money conversions, requests for payments, and promises of payments.
/// [Further reading](https://developer.paypal.com/docs/api/activities/v1/).
public final class Activities: PayPalController {
    public var container: Container
    public var resource: String
    
    public init(container: Container) {
        self.container = container
        self.resource = "activities"
    }
    
    /// Sends a request to the PayPal `GET /v{Configuration.version}/activities/activities` endpoint.
    ///
    /// [PayPal API docs](https://developer.paypal.com/docs/api/activities/v1/#activities_get).
    ///
    /// - Parameter parameters: The querys string parameters to send in the request URL.
    /// - Returns: The endpoint's response, decoded to an `ActivitiesResponse` object, wrapped in a future.
    public func activities(parameters: QueryParamaters = QueryParamaters()) -> Future<ActivitiesResponse> {
        return Future.flatMap(on: self.container) { () -> Future<ActivitiesResponse> in
            let client = try self.container.make(PayPalClient.self)
            return try client.get(self.path() + "activities?" + parameters.encode())
        }
    }
}
