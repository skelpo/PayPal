import Vapor

extension UserInfo {
    public struct Address: Content, Equatable {
        public let streetAddress: String?
        public let locality: String?
        public let region: String?
        public let zip: String?
        public let country: String?
    }
}
