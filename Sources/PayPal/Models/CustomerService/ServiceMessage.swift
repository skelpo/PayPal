import Vapor

extension CustomerService {
    public struct Message {}
}

extension CustomerService.Message {
    
    /// The type of message made by the customer service.
    public enum MessageType: String, Hashable, CaseIterable, Content {
        
        /// `ONLINE`
        case online = "ONLINE"
        
        /// `RETAIL`
        case retail = "RETAIL"
    }
}
