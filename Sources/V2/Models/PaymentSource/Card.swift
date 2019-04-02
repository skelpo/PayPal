import PayPal

extension PaymentSource {
    
    /// A payment card used to fund a transaction. This can be a credit card or a debit card.
    public struct Card: Codable {
        
        /// The PayPal-generated ID for the card.
        public let id: String?
        
        /// The last digits of the payment card.
        public let suffix: Failable<String?, NotNilValidate<Suffix>>
        
        /// The card brand or network. Typically used in the response.
        public let type: CardType?
        
        /// The card holder's name as it appears on the card.
        public var name: Optional300String
        
        /// The primary account number (PAN) for the payment card.
        public var number: Failable<String, Number>
        
        /// The card expiration year and month.
        public var expiry: YearMonthDate
        
        /// The three- or four-digit security code of the card. Also known as the CVV, CVC, CVN, CVE, or CID.
        public var securityCode: Failable<String?, NotNilValidate<SecurityCode>>
        
        /// The billing address for this card. Supports only the `address_line_1`, `address_line_2`, `admin_area_1`,
        /// `admin_area_2`, `postal_code`, and `country_code` properties.
        public var billing: Address?
        
        /// Creates a new `PaymentSource.Card` instance.
        ///
        /// - Parameters:
        ///   - name: The card holder's name as it appears on the card.
        ///   - number: The primary account number (PAN) for the payment card.
        ///   - expiry: The card expiration year and month.
        ///   - securityCode: The three- or four-digit security code of the card.
        public init(
            name: Optional300String,
            number: Failable<String, Number>,
            expiry: YearMonthDate,
            securityCode: Failable<String?, NotNilValidate<SecurityCode>>,
            billing: Address?
        ) {
            self.id = nil
            self.suffix = nil
            self.type = nil
            
            self.name = name
            self.number = number
            self.expiry = expiry
            self.securityCode = securityCode
            self.billing = billing
        }
        
        /// The validator for the `PaymentSource.Card.number` property value.
        public struct Number: RegexValidation {
            
            /// See `RegexValidator.patter`.
            public static let pattern: String = #"^\d{13,19}$"#
        }
        
        /// The validator for the `PaymentSource.Card.securityCode` property value.
        public struct SecurityCode: RegexValidation {
            
            /// See `RegexValidator.patter`.
            public static let pattern: String = "[0-9]{3,4}"
        }
        
        /// The validator for the `PaymentSource.Card.suffix` property,
        public struct Suffix: RegexValidation {
            
            /// See `RegexValidator.patter`.
            public static let pattern: String = "[0-9]{2,}"
        }
        
        enum CodingKeys: String, CodingKey {
            case id, name, number, expiry
            case suffix = "last_digits"
            case type = "card_type"
            case securityCode = "security_code"
            case billing = "billing_address"
        }
    }
    
    /// The valid card brand or network options for a `PaymentSource.Card` instance.
    public enum CardType: String, Hashable, CaseIterable, Codable {
        
        /// Visa card.
        case visa = "VISA"
        
        /// MasterCard card.
        case mastercard = "MASTERCARD"
        
        /// Discover card.
        case discover = "DISCOVER"
        
        /// American Express card.
        case amex = "AMEX"
        
        /// Solo debit card.
        case solo = "SOLO"
        
        /// Japan Credit Bureau card.
        case jcb = "JCB"
        
        /// Military Star card.
        case star = "STAR"
        
        /// Delta Airlines card.
        case delta = "DELTA"
        
        /// Switch credit card.
        case `switch` = "SWITCH"
        
        /// Maestro credit card.
        case maestro = "MAESTRO"
        
        /// Carte Bancaire (CB) credit card.
        case cbNationale = "CB_NATIONALE"
        
        /// Configoga credit card.
        case configoga = "CONFIGOGA"
        
        /// Confidis credit card.
        case confidis = "CONFIDIS"
        
        /// Visa Electron credit card.
        case electron = "ELECTRON"
        
        /// Cetelem credit card.
        case cetelem = "CETELEM"
        
        /// China union pay credit card.
        case chinaUnionPay = "CHINA_UNION_PAY"
    }
}
