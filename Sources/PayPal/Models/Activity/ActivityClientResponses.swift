import Vapor

extension Activity {
    
    /// The response structure returned from the `GET /v1/activities/activities` endpoint
    /// and `Activities.activities(parameters:)` client method.
    public struct Response: Content, Equatable {
        
        /// A list of the financial activities for a user.
        public var items: [Activity]?
        
        /// The [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links) related to the request.
        public let links: [LinkDescription]?
        
        /// Creates a new `ActivitiesResponse` instance.
        ///
        ///     ActivitiesResponse(items: [], links: [])
        public init(items: [Activity]?, links: [LinkDescription]?) {
            self.items = items
            self.links = links
        }
    }
}
