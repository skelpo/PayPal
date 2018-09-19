import Vapor

public struct AppContext {}

extension AppContext {
    
    /// The shipping preferences for an app context.
    public enum Shipping: String, Hashable, CaseIterable, Content {
        
        /// Redacts shipping address fields from the PayPal pages. Recommended value to use for digital goods.
        case none = "NO_SHIPPING"
        
        /// Get the shipping address selected by the buyer on PayPal pages.
        case buyer = "GET_FROM_FILE"
        
        /// Use the address provided by the merchant. Buyer is not able to change the address on the PayPal pages.
        /// If merchant does not pass an address, the buyer can choose the address on PayPal pages.
        case merchant = "SET_PROVIDED_ADDRESS"
    }
}
