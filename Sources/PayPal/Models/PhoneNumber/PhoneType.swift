import Vapor

public enum PhoneType: String, Hashable, CaseIterable, Content {
    case home = "HOME"
    case mobile = "MOBILE"
    case business = "BUSINESS"
    case work = "WORK"
    case customerService = "CUSTOMER_SERVICE"
    case fax = "FAX"
    case other = "OTHER"
    case pager = "PAGER"
}
