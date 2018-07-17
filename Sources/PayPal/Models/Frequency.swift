import Vapor

/// An interval unit, specifying the length of a time interval,
/// i.e. every _n_ `day`.
public enum Frequency: String, Hashable, CaseIterable, Content {
    
    /// The interval is how often in days an action should occur.
    case day = "DAY"
    
    /// The interval is how often in weeks an action should occur.
    case week = "WEEK"
    
    /// The interval is how often in monthes an action should occur.
    case month = "MONTH"
    
    /// The interval is how often in years an action should occur.
    case year = "YEAR"
}
