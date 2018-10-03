import Vapor

/// Customization for a payer's experience during the approval process for a payment with PayPal.
public struct AppContext: Content, ValidationSetable, Equatable {
    
    /// A label that overrides the business name in the PayPal account on the PayPal pages.
    ///
    /// This property can be set using the `AppContext.set(_:)` method. This method
    /// validates the new value before assigning it to the property.
    ///
    /// - Maximum length: 127.
    public var brand: String?
    
    /// The [language tag](https://tools.ietf.org/html/bcp47#section-2) for the language in which to localize the error-related strings, such as messages,
    /// issues, and suggested actions. The tag is made up of the [ISO 639-2 language code](https://www.loc.gov/standards/iso639-2/php/code_list.php),
    /// the optional [ISO-15924 script tag](https://www.unicode.org/iso15924/codelists.html), and the
    /// [ISO-3166 alpha-2 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/).
    ///
    /// This property can be set using the `AppContext.set(_:)` method. This method
    /// validates the new value before assigning it to the property.
    ///
    /// Minimum length: 2. Maximum length: 10. Pattern: `^[a-z]{2}(?:-[A-Z][a-z]{3})?(?:-(?:[A-Z]{2}))?$`.
    public var locale: String?
    
    /// The type of landing page to display on the PayPal site for user checkout. To use the non-PayPal account landing page,
    /// set to `Billing`. To use the PayPal account login landing page, set to `Login`.
    public var landingPage: String?
    
    /// The shipping preferences.
    public var shipping: Shipping?
    
    /// Defines whether to present the customer with a **Continue** or **Pay Now** checkout flow. To present buyers with the **Pay Now** checkout flow,
    /// set `useraction=commit`. Default is the **Continue** checkout flow.
    ///
    /// **Checkout flow**:
    /// - **Continue**:
    ///   - **Choose when**: You do not know the final payment amount when you initiate the checkout flow.
    ///   - **Description**: The default flow. Redirects the customer to the PayPal payment page, which shows the **Continue** button.
    ///   When the customer clicks **Continue**, the customer can change the payment amount.
    /// - **Pay Now**:
    ///   - **Choose when**: You know the final payment amount when you initiate the checkout flow.
    ///   - **Description**: Set `user_action=commit`. Redirects the customer to the PayPal payment page, which shows the **Pay Now** button.
    ///     When the customer clicks **Pay Now**, the payment is processed immediately.
    public var userAction: String?
    
    /// An array of name-and-value pairs that contain supplementary data required by PayPal for transaction processing.
    public var data: [NameValue]?
    
    
    /// Creates a new `AppContext` instance.
    ///
    /// - Parameters:
    ///   - brand: A label that overrides the business name in the PayPal account on the PayPal pages.
    ///   - locale: The language tag for the language in which to localize the error-related strings
    ///   - landingPage: The type of landing page to display on the PayPal site for user checkout.
    ///   - shipping: The shipping preferences.
    ///   - userAction: Defines whether to present the customer with a **Continue** or **Pay Now** checkout flow.
    ///   - data: An array of name-and-value pairs that contain supplementary data required by PayPal for transaction processing.
    public init(
       brand: String? = nil,
       locale: String? = nil,
       landingPage: String? = nil,
       shipping: Shipping? = nil,
       userAction: String? = nil,
       data: [NameValue]? = nil
    )throws {
        self.brand = brand
        self.locale = locale
        self.landingPage = landingPage
        self.shipping = shipping
        self.userAction = userAction
        self.data = data
        
        try self.set(\.brand <~ brand)
        try self.set(\.locale <~ locale)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            brand: container.decodeIfPresent(String.self, forKey: .brand),
            locale: container.decodeIfPresent(String.self, forKey: .locale),
            landingPage: container.decodeIfPresent(String.self, forKey: .landingPage),
            shipping: container.decodeIfPresent(Shipping.self, forKey: .shipping),
            userAction: container.decodeIfPresent(String.self, forKey: .userAction),
            data: container.decodeIfPresent([NameValue].self, forKey: .data)
        )
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<AppContext> {
        var validations = SetterValidations(AppContext.self)
        
        validations.set(\.brand) { brand in
            guard brand?.count ?? 0 <= 127 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`brand_name` value must have a length of 127 or less")
            }
        }
        validations.set(\.locale) { locale in
            guard let locale = locale else { return }
            let regex = "^[a-z]{2}(?:-[A-Z][a-z]{3})?(?:-(?:[A-Z]{2}))?$"
            guard locale.range(of: regex, options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`locale` value must match RegEx pattern '\(regex)'")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case locale
        case brand = "brand_name"
        case landingPage = "landing_page"
        case shipping = "shipping_preference"
        case userAction = "user_action"
        case data = "supplementary_data"
    }
}

extension AppContext {
    
    /// The shipping preferences for an app context.
    public enum Shipping: String, Hashable, CaseIterable, Content {
        
        /// Redacts shipping address fields from the PayPal pages. Recommended value to use for digital goods.
        case none = "NO_SHIPPING"
        
        /// Get the shipping address selected by the buyer on PayPal pages.
        case buyer = "GET_FROM_FILE"
        
        /// Use the address provided by the merchant. Buyer is not able to change the address on the PayPal pages.
        /// If merchant does not pass an address, the buyer can choose the address on PayPal pages.
        case merchant = "SET_PROVIDED_ADDRESS"
    }
}
