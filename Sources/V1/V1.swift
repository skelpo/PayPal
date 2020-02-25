@_exported import PayPal

extension API {
    
    /// Version 1 of the PayPal API resources.
    public var v1: V1 {
        return V1(client: self.client)
    }
}

/// A container for the controllers for version 1 of the PayPal API resources.
public struct V1 {
    
    /// The client used to send requests to PayPal.
    internal let client: PayPalClient
    
    /// Creates a new `V1` instance with the `PayPalClient` instance it will use.
    internal init(client: PayPalClient) {
        assert(client.version == .v1, "Make sure your PayPalClient instance is configured with the correct API version")
        self.client = client
    }
}
