import Vapor

extension Optional: RequestEncodable where Wrapped: Content {}
extension Optional: RequestDecodable where Wrapped: Content {}
extension Optional: ResponseEncodable where Wrapped: Content {}
extension Optional: ResponseDecodable where Wrapped: Content {}

extension Optional: Content where Wrapped: Content {
    
    /// See `Content.defaultContentType`.
    public static var defaultContentType: MediaType { return Wrapped.defaultContentType }
    
    /// See `RequestDecodable.decode(from:)`.
    public static func decode(from req: Request) throws -> EventLoopFuture<Optional<Wrapped>> {
        return try req.content.decode(Optional<Wrapped>.self)
    }
    
    /// See `Response.decode(from:for:)`.
    public static func decode(from res: Response, for req: Request) throws -> EventLoopFuture<Optional<Wrapped>> {
        return try res.content.decode(Optional<Wrapped>.self)
    }
    
    /// See `RequestEncodable.encode(using:)`.
    public func encode(using container: Container) throws -> EventLoopFuture<Request> {
        let req = Request(using: container)
        try req.content.encode(self)
        return container.future(req)
    }
    
    /// See `ResponseEncodable.encode(for:)`.
    public func encode(for req: Request) throws -> EventLoopFuture<Response> {
        let res = req.response()
        try res.content.encode(self)
        return req.future(res)
    }
}
