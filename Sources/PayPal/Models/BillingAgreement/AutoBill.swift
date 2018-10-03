import Vapor

/// Indicates whether PayPal automatically bills the outstanding balance
/// in the next billing cycle. The outstanding balance is the total
/// amount of any previously failed scheduled payments.
public enum AutoBill: String, Hashable, CaseIterable, Content {
    
    /// PayPal does not automatically bill the customer the outstanding balance
    ///
    /// This is the default value by the PayPal API.
    case no = "NO"
    
    /// PayPal automatically bills the customer the outstanding balance.
    case yes = "YES"
}
