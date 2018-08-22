import Vapor

extension CustomerService {
    public struct Message {
        public var type: MessageType
        public var headline: String?
        public var logo: String?
        public var serviceImage: String?
        public var sellerMessage: String
        
        public init(
            type: MessageType,
            headline: String?,
            logo: String?,
            serviceImage: String?,
            sellerMessage: String
        )throws {
            self.type = type
            self.headline = headline
            self.logo = logo
            self.serviceImage = serviceImage
            self.sellerMessage = sellerMessage
        }
    }
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
