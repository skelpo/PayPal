import Vapor

/// Business information, primerily used for a merchant account.
public struct Business: Content, ValidationSetable, Equatable {
    
    /// The type of business, such as corporation or sole proprietorship.
    public var type: BusinessType
    
    /// The business sub-type.
    public var subType: SubType?
    
    /// The government body.
    public var government: GovernmentBody?
    
    /// The place of establishment.
    public var establishment: Establishment?
    
    /// An array of different names for the business. For example, the legal name and the stock-trading name.
    ///
    /// - Note: You must set at least one /names/type to LEGAL.
    public var names: [Name]?
    
    /// An array of identification documents for the business.
    ///
    /// **US only**: This field is only required when type is set to `CORPORATION`, `PARTNERSHIP`, or `GOVERNMENT`.
    public var ids: [Identification]?
    
    /// An array of phones for the business. Includes the type, which is `BUSINESS` or `WORK`. Requires at least one phone number.
    public var phones: [TypedPhoneNumber]
    
    /// The category of the business. Either `merchant_category_code` or both `category` and `sub_category` are required.
    ///
    /// This property can be set using the `Business.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Length: 4.
    public private(set) var category: String?
    
    /// The sub-category of the business. Either `merchant_category_code` or both `category` and `sub_category` are required.
    ///
    /// This property can be set using the `Business.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Length: 4.
    public private(set) var subCategory: String?
    
    /// A merchant category code. Either `merchant_category_code` or both `category` and `sub_category` are required.
    ///
    /// This property can be set using the `Business.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Length: 4.
    public private(set) var merchantCategory: String?
    
    /// The date when the merchant's business was established, in [Internet date and time `full-date` format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public var establishedDate: TimelessDate?
    
    /// The date when the business was registered, in [Internet date and time `full-date` format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public var registrationDate: TimelessDate?
    
    /// The email address to which to send disputes, in [Simple Mail Transfer Protocol](https://www.ietf.org/rfc/rfc5321.txt) as defined in RFC 5321
    /// or in [Internet Message Format](https://www.ietf.org/rfc/rfc5322.txt) as defined in RFC 5322. Does not support Unicode email addresses.
    public var disputeEmail: EmailAddress?
    
    /// The details of business sales.
    public var sales: Sales?
    
    /// The customer service information.
    public var customerService: CustomerService?
    
    /// An array of merchant addresses.
    public var addresses: [Address]
    
    /// The [two-character ISO 3166-1 code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/) that identifies the country or region.
    ///
    /// This property can be set using the `Business.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// - Note: The country code for Great Britain is GB and not UK as used in the top-level domain names for that country.
    ///   Use the C2 country code for China worldwide for comparable uncontrolled price (CUP) method, bank card, and cross-border transactions.
    public private(set) var country: String?
    
    /// An array of business stakeholder information.
    public var stakeholders: [Stakeholder]?
    
    /// The business owner title and area.
    public var designation: Designation?
    
    
    /// Creates a new `Business` instance.
    ///
    ///     Business(
    ///         type: .individual,
    ///         subType: .unselected,
    ///         government: GovernmentBody(name: ""),
    ///         establishment: Establishment(state: "KS", country: "US"),
    ///         names: [],
    ///         ids: [],
    ///         phones: [],
    ///         category: "3145",
    ///         subCategory: "5972",
    ///         merchantCategory: "4653",
    ///         establishedDate: TimelessDate(date: "1882-05-13"),
    ///         registrationDate: TimelessDate(date: "1975-04-22"),
    ///         disputeEmail: EmailAddress(email: "disputable@exmaple.com"),
    ///         sales: .init(
    ///             price: MoneyRange("50"..."60", currency: .usd),
    ///             volume: MoneyRange("50"..."60", currency: .usd),
    ///             venues: [],
    ///             website: "https://nameless.io",
    ///             online: PercentRange(0...1)
    ///         ),
    ///         customerService: CustomerService(
    ///             email: EmailAddress(email: "help@nameless.com"),
    ///             phone: PhoneNumber(country: "1", number: "9963191901"),
    ///             message: []
    ///         ),
    ///         addresses: [],
    ///         country: "US",
    ///         stakeholders: [],
    ///         designation: .init(title: "CTO", area: "Software Engineering")
    ///     )
    public init(
        type: BusinessType,
        subType: SubType?,
        government: GovernmentBody?,
        establishment: Establishment?,
        names: [Name]?,
        ids: [Identification]?,
        phones: [TypedPhoneNumber],
        category: String?,
        subCategory: String?,
        merchantCategory: String?,
        establishedDate: TimelessDate?,
        registrationDate: TimelessDate?,
        disputeEmail: EmailAddress?,
        sales: Sales?,
        customerService: CustomerService?,
        addresses: [Address],
        country: String?,
        stakeholders: [Stakeholder]?,
        designation: Designation?
    )throws {
        self.type = type
        self.subType = subType
        self.government = government
        self.establishment = establishment
        self.names = names
        self.ids = ids
        self.phones = phones
        self.category = category
        self.subCategory = subCategory
        self.merchantCategory = merchantCategory
        self.establishedDate = establishedDate
        self.registrationDate = registrationDate
        self.disputeEmail = disputeEmail
        self.sales = sales
        self.customerService = customerService
        self.addresses = addresses
        self.country = country
        self.stakeholders = stakeholders
        self.designation = designation
        
        try self.set(\.category <~ category)
        try self.set(\.subCategory <~ subCategory)
        try self.set(\.merchantCategory <~ merchantCategory)
        try self.set(\.country <~ country)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        try self.init(
            type: container.decode(BusinessType.self, forKey: .type),
            subType: container.decodeIfPresent(SubType.self, forKey: .subType),
            government: container.decodeIfPresent(GovernmentBody.self, forKey: .government),
            establishment: container.decodeIfPresent(Establishment.self, forKey: .establishment),
            names: container.decodeIfPresent([Name].self, forKey: .names),
            ids: container.decodeIfPresent([Identification].self, forKey: .ids),
            phones: container.decode([TypedPhoneNumber].self, forKey: .phones),
            category: container.decodeIfPresent(String.self, forKey: .category),
            subCategory: container.decodeIfPresent(String.self, forKey: .subCategory),
            merchantCategory: container.decodeIfPresent(String.self, forKey: .merchantCategory),
            establishedDate: container.decodeIfPresent(TimelessDate.self, forKey: .establishedDate),
            registrationDate: container.decodeIfPresent(TimelessDate.self, forKey: .registrationDate),
            disputeEmail: container.decodeIfPresent(EmailAddress.self, forKey: .disputeEmail),
            sales: container.decodeIfPresent(Sales.self, forKey: .sales),
            customerService: container.decodeIfPresent(CustomerService.self, forKey: .customerService),
            addresses: container.decode([Address].self, forKey: .addresses),
            country: container.decodeIfPresent(String.self, forKey: .country),
            stakeholders: container.decodeIfPresent([Stakeholder].self, forKey: .stakeholders),
            designation: container.decodeIfPresent(Designation.self, forKey: .designation)
        )
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<Business> {
        var validations = SetterValidations(Business.self)
        
        validations.set(\.category) { category in
            guard let category = category else { return }
            guard category.count == 4 else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`category` value must have a length of 4")
            }
        }
        validations.set(\.subCategory) { category in
            guard let category = category else { return }
            guard category.count == 4 else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`sub_category` value must have a length of 4")
            }
        }
        validations.set(\.merchantCategory) { category in
            guard let category = category else { return }
            guard category.count == 4 else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`merchant_category` value must have a length of 4")
            }
        }
        validations.set(\.country) { country in
            guard let country = country else { return }
            guard country.range(of: "^([A-Z]{2}|C2)$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`country` value must match RegEx pattern `^([A-Z]{2}|C2)$`")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
       case type, names, phones, category, addresses, stakeholders, designation
       case subType = "sub_type"
       case government = "government_body"
       case establishment = "place_of_establishment"
       case ids = "identifications"
       case subCategory = "sub_category"
       case merchantCategory = "merchant_category_code"
       case establishedDate = "date_business_established"
       case registrationDate = "date_of_registration"
       case disputeEmail = "dispute_email"
       case sales = "business_sales_details"
       case customerService = "customer_service"
       case country = "country_code_of_incorporation"
    }
}
