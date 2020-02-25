import PayPal

extension Payer {
    
    /// The name of a payer. Supports only the `given_name` and `surname` properties
    public struct Name: Codable {
        
        /// When the party is a person, the party's given, or first, name.
        public var given: Failable<String?, NotNilValidate<Length140>>
        
        /// When the party is a person, the party's surname or family name. Also known as the last name.
        /// Required when the party is a person. Use also to store multiple surnames including the matronymic,
        /// or mother's, surname.
        public var surname: Failable<String?, NotNilValidate<Length140>>
        
        /// Creates a new `Payer.Name` instance.
        ///
        /// - Parameters:
        ///   - given: When the party is a person, the party's given, or first, name.
        ///   - surname: When the party is a person, the party's surname or family name.
        public init(
            given: Failable<String?, NotNilValidate<Length140>>,
            surname: Failable<String?, NotNilValidate<Length140>>
        ) {
            self.given = given
            self.surname = surname
        }
        
        enum CodingKeys: String, CodingKey {
            case given = "given_name"
            case surname
        }
    }
}
