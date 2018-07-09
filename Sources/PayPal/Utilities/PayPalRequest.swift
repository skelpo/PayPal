import Vapor

extension Container {
    func paypal<Body>(_ method: HTTPMethod, _ path: String, headers: HTTPHeaders = [:], auth: Bool = true, body: Body? = nil)throws -> Request where Body: Content {
        let config = try self.make(Configuration.self)
        
        var http = HTTPRequest(method: method, url: config.environment.domain + "/" + path, headers: headers)
        if auth {
            let auth = try self.make(AuthInfo.self)
            guard let type = auth.type, let token = auth.token else {
                throw Abort(.internalServerError, reason: "Attempted to make a PayPal request that requires auth before authenticating.")
            }
            
            http.headers.replaceOrAdd(name: .authorization, value: type + " " + token)
        }
        
        let request = Request(http: http, using: self)
        if let body = body {
            let contentType: MediaType = auth ? .json : .urlEncodedForm
            try request.content.encode(body, as: contentType)
        }
        return request
    }
}
