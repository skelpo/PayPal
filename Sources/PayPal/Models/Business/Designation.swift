import Vapor

extension Business {
    
    /// The business owner's title and his/her specific area of responsibility.
    public struct Designation: Content, Equatable {
        
        /// The business owner title.
        public var title: String?
        
        /// The organizational unit that corresponds to the specific business segment or area of responsibility in a company.
        public var area: String?
        
        
        /// Creates a new `Business.Designation` struct.
        ///
        ///     Designation(title: "CTO", area: "Software Engineering")
        public init(title: String?, area: String?) {
            self.title = title
            self.area = area
        }
        
        enum CodingKeys: String, CodingKey {
            case title
            case area = "business_area"
        }
    }
}
