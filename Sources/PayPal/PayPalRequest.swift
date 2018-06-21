import Vapor

extension Request {
    func paypal<Body>(_ method: HTTPMethod, _ path: String, headers: HTTPHeaders = [:], auth: Bool = true, body: Body? = nil)throws -> Request where Body: Content {
        let config = try self.make(Configuration.self)
        
        var http = HTTPRequest(method: method, url: config.environment.domain + "/" + path, headers: headers)
        if auth {
            let credentials = "\(config.id):\(config.secret)"
            let encoded = Data(credentials.utf8).base64EncodedString()
            http.headers.replaceOrAdd(name: .authorization, value: "Basic \(encoded)")
        }
        
        let request = Request(http: http, using: self)
        if let body = body {
            try request.content.encode(body, as: .urlEncodedForm)
        }
        return request
    }
}
