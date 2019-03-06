import Vapor

/// The wrapper for the whole PayPal REST API.
public final class API {
    
    /// The client used to send requests to PayPal.
    public let client: PayPalClient
    
    /// Creates a new `API` instance with the dependencies for the `PayPalClient` instance.
    ///
    /// - Parameters:
    ///   - client: The `Client` instance that the `PayPalClient` instance uses to send requests.
    ///   - environment: The PayPal environment to send requests to.
    public init(client: Client, version: Version, environment: Environment) {
        self.client = PayPalClient(client: client, version: version, env: environment)
    }
    
    /// Creates a new `API` instance with the `PayPalClient` instance to use.
    ///
    /// - Parameter client: The `PayPalClient` instance that will be used to send requests to the PayPal API.
    public init(client: PayPalClient) {
        self.client = client
    }
}
