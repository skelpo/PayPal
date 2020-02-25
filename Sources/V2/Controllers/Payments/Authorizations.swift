import PayPal
import Vapor

extension Payments {
    
    /// The controller for the `/authorizations` resource of the Payments PayPal API.
    public final class Authorizations: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["payments", "authorizations"]
        }
        
        /// Shows details for an authorized payment, by ID.
        ///
        /// A successful request returns the HTTP 200 OK status code and a JSON response body that shows authorization details.
        ///
        /// - Parameter authorization: The ID of the authorized payment for which to show details.
        /// - Returns: The authorization details for the ID passed in, wrapped in an `EventLoopFuture`.
        public func get(_ authorization: String) -> EventLoopFuture<Authorization> {
            return self.client.get(self.path + authorization, as: Authorization.self)
        }
        
        /// Captures an authorized payment, by ID.
        ///
        /// A successful request returns the HTTP 201 Created status code
        /// and a JSON response body that shows captured payment details.
        ///
        /// - Parameters:
        ///   - authorization: The PayPal-generated ID for the authorized payment to capture.
        ///   - capture: The capture information for the payment, which will be the body for the request.
        ///   - prefer: The preferred server response upon successful completion of the request.
        ///   - requestID: A unique user-generated ID that the server stores for a period of time.
        ///     Use this header to enforce idempotency on REST API POST calls.
        ///
        /// - Returns: The captured payment, wrapped in an `EventLoopFuture`.
        public func capture(
            _ authorization: String,
            capture: Authorization.Capture,
            prefer: PreferResponse = .minimal,
            requestID: String? = nil
        ) -> EventLoopFuture<Capture> {
            var headers: HTTPHeaders = ["Prefer": prefer.rawValue]
            if let request = requestID {
                headers.add(name: "PayPal-Request-Id", value: request)
            }
            
            return self.client.post(self.path + authorization + "/capture", headers: headers, body: capture, as: Capture.self)
        }
        
        /// Reauthorizes an authorized PayPal account payment, by ID. To ensure that funds are still available,
        /// reauthorize a payment after its initial three-day honor period expires.
        /// You can reauthorize a payment only once from days four to 29.
        ///
        /// If 30 days have transpired since the date of the original authorization,
        /// you must create an authorized payment instead of reauthorizing the original authorized payment.
        ///
        /// A reauthorized payment itself has a new honor period of three days.
        ///
        /// You can reauthorize an authorized payment once for up to 115% of the original authorized amount,
        /// not to exceed an increase of $75 USD.
        ///
        /// Supports only the `amount` request parameter.
        ///
        /// - Note: This request is currently not supported for Partner use cases.
        ///
        /// A successful request returns the HTTP 201 Created status code and
        /// a JSON response body that shows the reauthorized payment details.
        ///
        /// - Parameters:
        ///   - authorization: The PayPal-generated ID for the authorized payment to reauthorize.
        ///   - amount: The amount to reauthorize for an authorized payment.
        ///   - prefer: The preferred server response upon successful completion of the request.
        ///   - requestID: A unique user-generated ID that the server stores for a period of time.
        ///     Use this header to enforce idempotency on REST API POST calls.
        ///
        /// - Returns: The reauthorizaed payment, wrapped in an `EventLoopFuture`.
        public func reauthorize(
            _ authorization: String,
            amount: CurrencyCodeAmount,
            prefer: PreferResponse = .minimal,
            requestID: String? = nil
        ) -> EventLoopFuture<Authorization> {
            var headers: HTTPHeaders = ["Prefer": prefer.rawValue]
            if let request = requestID {
                headers.add(name: "PayPal-Request-Id", value: request)
            }
            
            return self.client.post(
                self.path + authorization + "/reauthorize",
                headers: headers,
                body: amount,
                as: Authorization.self
            )
        }
        
        /// Voids, or cancels, an authorized payment, by ID.
        /// You cannot void an authorized payment that has been fully captured.
        ///
        /// A successful request returns the HTTP 204 No Content status code with no JSON response body.
        ///
        /// - Parameter authorization: The PayPal-generated ID for the authorized payment to void.
        /// - Returns: An empty `EventLoopFuture` that succeedes if the API response gives a success code.
        public func void(_ authorization: String) -> EventLoopFuture<Void> {
            return self.client.post(self.path + authorization + "/void", as: HTTPStatus.self).transform(to: ())
        }
    }
}
