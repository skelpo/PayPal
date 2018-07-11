import Vapor

/// Valid HTTP methods for [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links) from the PayPal API.
public enum Method: String, Hashable, CaseIterable, Content {
    
    ///
    case GET, POST, PUT, DELETE, HEAD, CONNECT, OPTIONS, PATCH
}
