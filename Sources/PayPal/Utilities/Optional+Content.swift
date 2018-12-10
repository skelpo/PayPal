import Vapor

extension Optional: RequestEncodable where Wrapped: Content {}
extension Optional: RequestDecodable where Wrapped: Content {}
extension Optional: ResponseEncodable where Wrapped: Content {}
extension Optional: ResponseDecodable where Wrapped: Content {}

extension Optional: Content where Wrapped: Content {
    public static var defaultContentType: MediaType { return Wrapped.defaultContentType }
    
    public static func decode(from req: Request) throws -> EventLoopFuture<Optional<Wrapped>> {
        return try req.content.decode(Optional<Wrapped>.self)
    }
    
    public static func decode(from res: Response, for req: Request) throws -> EventLoopFuture<Optional<Wrapped>> {
        return try res.content.decode(Optional<Wrapped>.self)
    }
    
    public func encode(using container: Container) throws -> EventLoopFuture<Request> {
        let req = Request(using: container)
        try req.content.encode(self)
        return container.future(req)
    }
    
    public func encode(for req: Request) throws -> EventLoopFuture<Response> {
        let res = req.response()
        try res.content.encode(self)
        return req.future(res)
    }
}
