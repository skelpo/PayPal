import Vapor

/// For most REST `GET` calls, you can specify one or more optional query parameters
/// on the request URI to [filter](https://developer.paypal.com/docs/api/glossary/#filtering),
/// [limit the size of](https://developer.paypal.com/docs/api/glossary/#pagination),
/// and sort the data in an API response. For filter parameters, see the individual GET calls.
///
/// To limit, or _page_, and sort the data that is returned in some API responses, use these, or similar, query parameters:
///
/// - Note: Not all pagination parameters are available for all APIs.
public struct QueryParamaters: Content {
    
    /// The number of items to list in the response.
    public var count: Int?
    
    /// The end date and time for the range to show in the response,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// For example, `end_time=2016-03-06T11:00:00Z`.
    public var endTime: Date?
    
    /// The zero-relative start index of the entire list of items that are returned in the response.
    /// So, the combination of `next_page_token=1` and `page_size=20` returns the first 20 items.
    ///
    /// - Note: The encoded key for this property is `next_page_token`.
    public var page: Int?
    
    /// The number of items to return in the response.
    public var pageSize: Int?
    
    /// Indicates whether to show the total count in the response.
    public var totalCountRequired: Bool?
    
    /// Sorts the payments in the response by a specified value, such as the create time or update time.
    public var sortBy: String?
    
    /// Sorts the items in the response in ascending or descending order.
    public var sortOrder: ResponseSortOrder?
    
    /// The ID of the starting resource in the response. When results are paged,
    /// you can use the `next_id` value as the `start_id` to continue with the next set of results.
    public var startID: String?
    
    /// The start index of the payments to list. Typically, you use the `start_index` to jump
    /// to a specific position in the resource history based on its cart. For example,
    /// to start at the second item in a list of results, specify `?start_index=2`.
    public var startIndex: Int?
    
    /// The start date and time for the range to show in the response,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// For example, `start_time=2016-03-06T11:00:00Z`.
    public var startTime: Date?
    
    /// Any endpoint specific querystring paramaters.
    public var custom: [String: String]?
    
    /// Creates a new `QueryParamaters` instance
    ///
    /// All paramaters have a default `nil` value, so you only need to pass
    /// in the values that you need.
    ///
    ///     QueryParamaters(page: 0, pageSize: 25, sortOrder: .ascending)
    public init(
        count: Int? = nil,
        startTime: Date? = nil,
        endTime: Date? = nil,
        page: Int? = nil,
        pageSize: Int? = nil,
        totalCountRequired: Bool? = nil,
        sortBy: String? = nil,
        sortOrder: ResponseSortOrder? = nil,
        startID: String? = nil,
        startIndex: Int? = nil,
        custom: [String: String]? = nil
    ) {
        self.count = count
        self.endTime = endTime
        self.page = page
        self.pageSize = pageSize
        self.totalCountRequired = totalCountRequired
        self.sortBy = sortBy
        self.sortOrder = sortOrder
        self.startID = startID
        self.startIndex = startIndex
        self.startTime = startTime
        self.custom = custom
    }
    
    /// Converts the query's properties to a query string representation.
    ///
    ///     QueryParamaters(page: 0, pageSize: 25, sortOrder: .ascending).encode()
    ///
    ///     // "next_page_token=0&page_size=25&sort_order=ascending"
    public func encode() -> String {
        var values: [String: CustomStringConvertible?] = [
            "count": self.count, "end_time": self.endTime?.iso8601, "next_page_token": self.page, "page_size": self.pageSize,
            "total_count_required": self.totalCountRequired, "sort_by": self.sortBy, "sort_order": self.sortOrder,
            "start_id": self.startID, "start_index": self.startIndex, "start_time": self.startTime?.iso8601
        ]
        values.merge(self.custom ?? [:]) { _, value in return value }
        
        return (values).reduce(into: []) { query, parameter in
            if let value = parameter.value {
                query.append("\(parameter.key)=\(value.description)")
            }
        }.joined(separator: "&")
    }
}

/// To specify which order the items in a response should be received from the PayPal API.
public enum ResponseSortOrder: String, Codable, CustomStringConvertible {
    
    ///
    case ascending
    
    ///
    case descending
    
    /// The raw value of the case.
    public var description: String {
        return self.rawValue
    }
}
