import Failable
import PayPal

/// The customer who approves and pays for an order.
public struct Payer: Codable {
    
    /// The name of the payer. Supports only the `given_name` and `surname` properties.
    public var name: Name?
    
    /// The email address of the payer.
    public var email: Failable<String?, NotNilValidate<EmailValidation>>
    
    /// The PayPal assigned ID for the payer.
    public var payer: Failable<String?, NotNilValidate<IDValidation>>
    
    /// The phone number of the customer. Available only when you enable the **Contact Telephone Number** option in the
    /// [Profile & Settings](https://www.paypal.com/cgi-bin/customerprofileweb?cmd=_profile-website-payments) for the
    /// merchant's PayPal account. The `phone.phone_number` supports only `national_number`.
    public var phone: Phone?
    
    /// The birth date of the payer in `YYYY-MM-DD` format.
    public var birthdate: TimelessDate?
    
    /// The tax information of the payer. Required only for Brazilian payer's. Both `tax_id` and `tax_id_type` are required.
    public var tax: TaxInfo?
    
    /// The address of the payer. Supports only the `address_line_1`, `address_line_2`, `admin_area_1`, `admin_area_2`,
    /// `postal_code`, and `country_code` properties. Also referred to as the billing address of the customer.
    public var address: Address?
    
    /// Creates a new `Payer` instance.
    ///
    /// - Parameters:
    ///   - name: The name of the payer.
    ///   - email: The email address of the payer.
    ///   - payer: The PayPal assigned ID for the payer.
    ///   - phone: The phone number of the customer.
    ///   - birthdate: The birth date of the payer in `YYYY-MM-DD` format.
    ///   - tax: The tax information of the payer.
    ///   - address: The address of the payer.
    public init(
        name: Name?,
        email: Failable<String?, NotNilValidate<EmailValidation>>,
        payer: Failable<String?, NotNilValidate<IDValidation>>,
        phone: Phone?,
        birthdate: TimelessDate?,
        tax: TaxInfo?,
        address: Address?
    ) {
        self.name = name
        self.email = email
        self.payer = payer
        self.phone = phone
        self.birthdate = birthdate
        self.tax = tax
        self.address = address
    }
    
    enum CodingKeys: String, CodingKey {
        case name, phone, address
        case email = "email_address"
        case payer = "payer_id"
        case birthdate = "birth_date"
        case tax = "tax_info"
    }
}
