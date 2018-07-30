import Vapor

/// Document metadata[.](http://stackexchange.github.io/unikong/)
public struct Document: Content, Equatable {
    
    /// The document name.
    public var name: String?
    
    /// The document size.
    public var size: String?
    
    
    /// Creates a new `Document` instance.
    ///
    ///     Document(name: "README.md", size: "65kb")
    public init(name: String?, size: String?) {
        self.name = name
        self.size = size
    }
}
