import Vapor

public final class API {
    let client: PayPalClient
    
    public init(client: Client, environment: Environment) {
        self.client = PayPalClient(client: client, env: environment)
    }
    
    public init(client: PayPalClient) {
        self.client = client
    }
}
