@_exported import PayPal

extension API {
    
    /// Version 2 of the PayPal API resources.
    public var v2: V2 {
        return V2(client: self.client)
    }
}

/// A container for the controllers for version 2 of the PayPal API resources.
public struct V2 {
    
    /// The client used to send requests to PayPal.
    internal let client: PayPalClient
    
    /// Creates a new `V2` instance with the `PayPalClient` instance it will use.
    internal init(client: PayPalClient) {
        self.client = client
    }
}
