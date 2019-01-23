import Vapor

extension CustomerService {
    
    /// A message sent by the customer service of a business or organizat
    public struct Message: Content, Equatable {
        
        /// The type of customer service message
        public var type: MessageType
        
        /// The headline.
        ///
        /// Maximum length: 50.
        public var headline: Failable<String?, NotNilValidate<Length50>>
        
        /// The logo image URL.
        ///
        /// Maximum length: 255.
        public var logo: Failable<String?, NotNilValidate<Length255>>
        
        /// The service image URL.
        ///
        /// Maximum length: 255.
        public var serviceImage: Failable<String?, NotNilValidate<Length255>>
        
        /// The seller message.
        ///
        /// Maximum length: 2000.
        public var sellerMessage: Failable<String, Length2000>
        
        
        /// Creates a new `CustomerService.Message` instance.
        ///
        /// - Parameters:
        ///   - headline: The headline.
        ///   - logo: The logo image URL.
        ///   - serviceImage: The service image URL.
        ///   - sellerMessage: The seller message.
        public init(
            type: MessageType,
            headline: Failable<String?, NotNilValidate<Length50>>,
            logo: Failable<String?, NotNilValidate<Length255>>,
            serviceImage: Failable<String?, NotNilValidate<Length255>>,
            sellerMessage: Failable<String, Length2000>
        ) {
            self.type = type
            self.headline = headline
            self.logo = logo
            self.serviceImage = serviceImage
            self.sellerMessage = sellerMessage
        }
        
        enum CodingKeys: String, CodingKey {
            case type, headline
            case logo = "logo_image_url"
            case serviceImage = "service_image_url"
            case sellerMessage = "seller_message"
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
