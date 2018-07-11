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
    
    func paypal<Body, Result>(
        _ method: HTTPMethod,
        _ path: String,
        headers: HTTPHeaders = [:],
        body: Body?,
        as response: Result.Type = Result.self
    ) -> Future<Result> where Body: Content, Result: Content {
        return Future.flatMap(on: self) { () -> Future<Void> in
            if try self.make(AuthInfo.self).tokenExpired == true {
                return try self.make(PayPalClient.self).authenticate()
            } else {
                return self.future()
            }
        }.flatMap(to: Response.self) {
            let request = try self.paypal(method, path, headers: headers, auth: true, body: body)
            return try self.client().send(request)
        }.flatMap(to: Result.self) { response in
            if !(200...299).contains(response.http.status.code) {
                return try response.content.decode(PayPalAPIError.self).map { error in throw error }
            }
            
            return try response.content.decode(Result.self)
        }
    }
    
    func paypal<Result>(
        _ method: HTTPMethod,
        _ path: String,
        headers: HTTPHeaders = [:],
        as response: Result.Type = Result.self
    ) -> Future<Result> where Result: Content {
        return self.paypal(method, path, headers: headers, body: nil as [String: String]?, as: Result.self)
    }
}
