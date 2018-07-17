import Vapor

/// An endpoint that can be fired after a different endpoint to
/// run further actions on the resource.
public struct LinkDescription: Content, Equatable {
    
    /// The complete target URL. To make the related call, combine the method with
    /// this [URI Template-formatted](https://tools.ietf.org/html/rfc6570) link.
    /// For pre-processing, include the `$`, `(`, and `)` characters. The `href`
    /// is the key HATEOAS component that links a completed call with a subsequent call.
    public var href: String
    
    /// The [link relation type](https://tools.ietf.org/html/rfc5988#section-4),
    /// which serves as an ID for a link that unambiguously describes the semantics of the link.
    /// See [Link Relations](https://www.iana.org/assignments/link-relations/link-relations.xhtml).
    public var rel: String
    
    /// The HTTP method required to make the related call.
    public var method: Method?
    
    /// Creates a new `LinkDescription` instance:
    ///
    ///     LinkDescription(href: "https://choosealicense.com/licenses/mit/", rel: "license", method: .GET)
    init(href: String, rel: String, method: Method?) {
        self.href = href
        self.rel = rel
        self.method = method
    }
    
    /// Compares two `LinkDescription` objects, checking that the `href`,
    /// `rel`, and `method` properties are equal.
    public static func == (lhs: LinkDescription, rhs: LinkDescription) -> Bool {
        return (lhs.rel == rhs.rel) && (lhs.href == rhs.href) && (lhs.method == rhs.method)
    }
}
