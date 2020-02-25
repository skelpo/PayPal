/// The preferred server response upon successful completion of a request.
public enum PreferResponse: String {
    
    /// The server returns a minimal response to optimize communication between the API caller and the server.
    /// A minimal response includes the `id`, `status` and HATEOAS links.
    case minimal = "return=minimal"
    
    /// The server returns a complete resource representation, including the current state of the resource.
    case representation = "return=representation"
}
