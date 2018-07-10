import Vapor

public protocol PayPalController: ServiceType {
    var container: Container { get }
    var resource: String { get }
    
    init(container: Container)
}
