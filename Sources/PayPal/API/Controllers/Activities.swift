import Vapor

/// Use the Activities API to list the financial activities for a user.
/// Activities are records for all payments, currency transfers, money conversions,
/// requests for payments, and promises of payments. To filter or limit the size of the list,
/// you can specify one or more query parameters.
/// For more information, see the [Activities Integration Guide](https://developer.paypal.com/docs/integration/direct/activities/).
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
            return try client.get(self.path() + "activities", parameters: parameters)
        }
    }
}
