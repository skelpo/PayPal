import Vapor

extension HTTPStatus: Content {
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let code = try container.decode(Int.self)
        self = .init(statusCode: code)
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.code)
    }
    
    /// See [`ResponseDecodable.decode(from:for:)`](https://api.vapor.codes/vapor/latest/Vapor/Protocols/ResponseDecodable.html#/s:5Vapor17ResponseDecodableP6decodeXeXeFZ).
    public static func decode(from res: Response, for req: Request) throws -> Future<HTTPStatus> {
        return req.future(res.http.status)
    }
    
    /// See [`ResponseEncodable.encode(for:)`](https://api.vapor.codes/vapor/latest/Vapor/Protocols/ResponseEncodable.html#/s:5Vapor17ResponseEncodableP6encodeXeXeF).
    public func encode(for req: Request) throws -> Future<Response> {
        let response = req.response()
        response.http.status = self
        return req.future(response)
    }
}
