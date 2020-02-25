import Failable
import PayPal

/// Used to customize the payer's experience during the approval process for a PayPal payment.
public struct AppContext: Codable {
    
    /// The label that overrides the business name in the PayPal account on the PayPal site.
    public var brand: Optional127String
    
    /// The BCP 47-formatted locale of pages that the PayPal payment experience shows. PayPal supports a five-character code.
    /// For example, `da-DK`, `he-IL`, `id-ID`, `ja-JP`, `no-NO`, `pt-BR`, `ru-RU`, `sv-SE`, `th-TH`, `zh-CN`, or `zh-HK`.
    public var locale: Failable<String?, NotNilValidate<LocaleString>>
    
    /// The type of landing page to show on the PayPal site for customer checkout.
    public var landingPage: LandingPage?
    
    /// The shipping preference:
    /// - Displays the shipping address to the customer.
    /// - Enables the customer to choose an address on the PayPal site.
    /// - Restricts the customer from changing the address during the payment-approval process.
    public var shipping: ShippingPreference?
    
    /// Configures a **Continue** or **Pay Now** checkout flow.
    public var userAction: UserAction?
    
    /// The customer and merchant payment preferences.
    public var payment: PaymentMethod?
    
    /// The URL where the customer is redirected after the customer approves the payment.
    public var `return`: String?
    
    /// The URL where the customer is redirected after the customer cancels the payment.
    public var cancel: String?
    
    
    /// Creates a new `AppContext` instance.
    ///
    /// - Parameters:
    ///   - brand: The label that overrides the business name in the PayPal account on the PayPal site.
    ///   - locale: The BCP 47-formatted locale of pages that the PayPal payment experience shows.
    ///   - landingPage: The type of landing page to show on the PayPal site for customer checkout. Defaults to `.login`.
    ///   - shipping: The shipping preference:
    ///     - Displays the shipping address to the customer.
    ///     - Enables the customer to choose an address on the PayPal site.
    ///     - Restricts the customer from changing the address during the payment-approval process.
    ///     Detaults to `.fromFile`.
    ///   - userAction: Configures a **Continue** or **Pay Now** checkout flow.
    ///   - payment: The customer and merchant payment preferences.
    ///   - return: The URL where the customer is redirected after the customer approves the payment.
    ///   - cancel: The URL where the customer is redirected after the customer cancels the payment.
    public init(
        brand: Optional127String,
        locale: Failable<String?, NotNilValidate<LocaleString>>,
        landingPage: LandingPage? = .login,
        shipping: ShippingPreference? = .fromFile,
        userAction: UserAction?,
        payment: PaymentMethod?,
        `return`: String?,
        cancel: String?
    ) {
        self.brand = brand
        self.locale = locale
        self.landingPage = landingPage
        self.shipping = shipping
        self.userAction = userAction
        self.payment = payment
        self.`return` = `return`
        self.cancel = cancel
    }
    
    /// The options for what type of landing page to show on the PayPal site for customer checkout.
    public enum LandingPage: String, Hashable, CaseIterable, Codable {
        
        /// (Default) When the customer clicks **PayPal Checkout**, the customer is redirected to a page
        /// to log in to PayPal and approve the payment.
        case login = "LOGIN"
        
        /// When the customer clicks **PayPal Checkout**, the customer is redirected to a page to enter credit
        /// or debit card and other relevant billing information required to complete the purchase.
        case billing = "BILLING"
    }
    
    /// The shipping preferance options for a given app context.
    public enum ShippingPreference: String, Hashable, CaseIterable, Codable {
        
        /// (Default) Use the customer-provided shipping address on the PayPal site.
        case fromFile = "GET_FROM_FILE"
        
        /// Redact the shipping address from the PayPal site. Recommended for digital goods.
        case none = "NO_SHIPPING"
        
        /// Use the merchant-provided address. The customer cannot change this address on the PayPal site.
        case provided = "SET_PROVIDED_ADDRESS"
    }
    
    
    /// The configuration options for a **Continue** or **Pay Now** checkout flow.
    public enum UserAction: String, Hashable, CaseIterable, Codable {
        
        /// (Default) After you redirect the customer to the PayPal payment page, a **Continue** button appears.
        /// Use this option when the final amount is not known when the checkout flow is initiated and you want
        /// to redirect the customer to the merchant page without processing the payment.
        case `continue` = "CONTINUE"
        
        /// After you redirect the customer to the PayPal payment page, a **Pay Now** button appears.
        /// Use this option when the final amount is known when the checkout is initiated and you want to
        /// process the payment immediately when the customer clicks **Pay Now**.
        case payNow = "PAY_NOW"
    }
    
    enum CodingKeys: String, CodingKey {
        case locale
        case brand = "brand_name"
        case landingPage = "landing_page"
        case shipping = "shipping_preference"
        case userAction = "user_action"
        case payment = "payment_method"
        case `return` = "return_url"
        case cancel = "cancel_url"
    }
}
