import Vapor

public final class Provider: Vapor.Provider {
    public func register(_ services: inout Services) throws {
        
    }
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return container.future()
    }
}
