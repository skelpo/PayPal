import Vapor

extension Order {
    
    /// The name-and-value pairs that contain external data, such as user, user feedback, score, and so on.
    public struct Metadata: Content, Equatable {
        
        /// An array of name-and-value pairs that contain data required by PayPal for transaction processing.
        public var data: [NameValue]?
        
        /// Creates a new `Order.Metadata` instance.
        ///
        /// - Parameter data: An array of name-and-value pairs that contain data required by PayPal for transaction processing.
        public init(data: [NameValue]?) {
            self.data = data
        }
        
        enum CodingKeys: String, CodingKey {
            case data = "supplementary_data"
        }
    }
}
