import Vapor

/// All valid query string parameters for any given PayPal API request.
///
/// - Note: Not all query strings will effect a request.
///   Some pagination paramaters will not effect certain endpoints.
public struct QueryParamaters: Content {
    
    /// The number of items to list in the response.
    public var count: Int?
    
    /// The end date and time for the range to show in the response,
    /// in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// For example, `end_time=2016-03-06T11:00:00Z`.
    public var endTime: String?
    
    /// The zero-relative start index of the entire list of items that are returned in the response.
    /// So, the combination of `page=0` and `page_size=20` returns the first 20 items.
    /// The combination of `page=20` and `page_size=20` returns the next 20 items.
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
    public var startTime: String?
}

/// To specify which order the items in a response should be received from the PayPal API.
public enum ResponseSortOrder: String, Codable {
    
    ///
    case ascending
    
    /// 
    case descending
}
