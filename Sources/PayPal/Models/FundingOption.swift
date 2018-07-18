import Vapor

/// The valid values for the `Payer.fundingOption` property.
///
/// The PayPal API calls for a string, but because there are only 2
/// valid values and an enum with a string raw value will be encoded
/// to a string, an enum adds additional type safty to the property.
public enum FundingOption: String, Hashable, CaseIterable, Content {
    
    /// `funding_option_id`
    case id = "funding_option_id"
    
    /// `funding_instruments`
    case instruments = "funding_instruments"
}
