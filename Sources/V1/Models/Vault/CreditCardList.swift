import PayPal

extension CreditCard {

    /// A paginated list of credit cards from a user's vault.
    public struct List: Codable {

        /// An array of credit card objects.
        public var cards: [CreditCard]?

        /// The total number of items.
        public var count: Int32?

        /// The total number of pages.
        public var pages: Int32?

        /// An array of request-specific
        /// [HATEOAS links](https://developer.paypal.com/docs/api/reference/api-responses/#hateoas-links).
        public let links: [LinkDescription]?

        /// Creates a new `CreditCard.List` struct.
        ///
        /// - Parameters:
        ///   - cards: An array of credit card objects.
        ///   - count: The total number of items.
        ///   - pages: The total number of pages.
        public init(cards: [CreditCard]?, count: Int32?, pages: Int32?) {
            self.cards = cards
            self.count = count
            self.pages = pages
            self.links = nil
        }

        enum CodingKeys: String, CodingKey {
            case links
            case cards = "items"
            case count = "total_items"
            case pages = "total_pages"
        }
    }
}
