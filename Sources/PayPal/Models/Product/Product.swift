import Vapor

/// Data that acts as a product's status that are integrated with a partner for a seller.
public struct Product: Content {
    
    /// The name of the product.
    public var name: Name?
    
    /// The vetting status of the product, if applicable.
    public var vettingStatus: VettingStatus?
    
    /// Indicates whether the product is active.
    public var active: Bool?
    
    /// Creates a new `Product` instance.
    ///
    /// - Parameters:
    ///   - name: The name of the product.
    ///   - vettingStatus: The vetting status of the product, if applicable.
    ///   - active: Indicates whether the product is active.
    public init(name: Name?, vettingStatus: VettingStatus?, active: Bool?) {
        self.name = name
        self.vettingStatus = vettingStatus
        self.active = active
    }
    
    enum CodingKeys: String, CodingKey {
        case name, active
        case vettingStatus = "vetting_status"
    }
}
