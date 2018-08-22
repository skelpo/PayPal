import Vapor

extension CustomerService {
    
    /// A message sent by the customer service of a business or organizat
    public struct Message: Content, ValidationSetable, Codable {
        
        /// The type of customer service message
        public var type: MessageType
        
        /// The headline.
        ///
        /// This property can be set using the `Message.set(_:)` method. This method
        /// will validate the new value before assiging it to the property
        ///
        /// Maximum length: 50.
        public private(set) var headline: String?
        
        /// The logo image URL.
        ///
        /// This property can be set using the `Message.set(_:)` method. This method
        /// will validate the new value before assiging it to the property
        ///
        /// Maximum length: 255.
        public private(set) var logo: String?
        
        /// The service image URL.
        ///
        /// This property can be set using the `Message.set(_:)` method. This method
        /// will validate the new value before assiging it to the property
        ///
        /// Maximum length: 255.
        public private(set) var serviceImage: String?
        
        /// The seller message.
        ///
        /// This property can be set using the `Message.set(_:)` method. This method
        /// will validate the new value before assiging it to the property
        ///
        /// Maximum length: 2000.
        public private(set) var sellerMessage: String
        
        
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
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<CustomerService.Message> {
            var validations = SetterValidations(Message.self)
            
            validations.set(\.headline) { headline in
                guard let headline = headline else { return }
                guard headline.count <= 50 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`headline` length must be 50 for less")
                }
            }
            validations.set(\.logo) { logo in
                guard let logo = logo else { return }
                guard logo.count <= 255 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`logo` length must be 255 for less")
                }
            }
            validations.set(\.serviceImage) { serviceImage in
                guard let serviceImage = serviceImage else { return }
                guard serviceImage.count <= 255 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`service_image` length must be 255 for less")
                }
            }
            validations.set(\.sellerMessage) { sellerMessage in
                guard sellerMessage.count <= 2000 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`seller_message` length must be 255 for less")
                }
            }
            
            
            return validations
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
