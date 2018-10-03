import Vapor

/// Files attached to a PayPal action.
public struct FileAttachment: Content, Equatable {
    
    /// The name of the attached file
    public var name: String?
    
    /// The URL of the attached file. Use this URL to download the file.
    public var url: String?
    
    /// Creates a new `FileAttachment` instance.
    ///
    ///     FileAttachment(name: "photo.jpg", url: "https://avatars3.githubusercontent.com/u/2872298?s=200&v=4")
    public init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}
