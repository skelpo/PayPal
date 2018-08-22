import Vapor

extension CustomerService {
    
    /// A message sent by the customer service of a business or organizat
    public struct Message: Content, Codable {
        
        /// The type of customer service message
        public var type: MessageType
        
        /// The headline.
        public var headline: String?
        
        /// The logo image URL.
        public var logo: String?
        
        /// The service image URL.
        public var serviceImage: String?
        
        /// The seller message.
        public var sellerMessage: String
        
        
        /// Creates a new `CustomerService.Message` instance.
        ///
        ///     CustomerService.Message(type: .online, headline: "Extra!", logo: "url-placeholder", serviceImage: "url", sellerMessage: "Titanic sunk...")
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
