import Vapor

extension BusinessOwner {
    public struct ID: Content, Equatable {
        public var type: IDType
        public var value: String
        public var masked: Bool?
        public var issuerCountry: String
        public var issuerState: String?
        public var issuerCity: String?
        public var placeOfIssue: String?
        public var description: String?
        
        public init(
            type: IDType,
            value: String,
            masked: Bool?,
            issuerCountry: String,
            issuerState: String?,
            issuerCity: String?,
            placeOfIssue: String?,
            description: String?
        ) {
            self.type = type
            self.value = value
            self.masked = masked
            self.issuerCountry = issuerCountry
            self.issuerState = issuerState
            self.issuerCity = issuerCity
            self.placeOfIssue = placeOfIssue
            self.description = description
        }
    }
}
