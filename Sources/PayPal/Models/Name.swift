import Vapor

/// The name of a person, broken into specific parts.
public struct Name: Content, ValidationSetable,  Equatable {
    
    /// The prefix, or title, to the party name.
    ///
    /// Maximum length: 140.
    public var prefix: String?
    
    /// The person party's given, or first, name.
    ///
    /// Maximum length: 140.
    public var given: String?
    
    /// The person party's surname or family name. Also known as the last name. Required if the party is a person.
    /// Use also to store multiple surnames including the matronymic, or mother's, surname.
    ///
    /// Maximum length: 140.
    public var surname: String?
    
    /// The person party's middle name. Use also to store multiple middle names including the patronymic, or father's, middle name.
    ///
    /// Maximum length: 140.
    public var middle: String?
    
    /// The suffix for the party's name.
    ///
    /// Maximum length: 140.
    public var suffix: String?
    
    /// The person party's full name.
    ///
    /// Maximum length: 300.
    public var full: String?
    
    
    /// Creates a new `Name` instance.
    ///
    ///     Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "auth.", full: "Sir Walter Scott")
    public init(prefix: String?, given: String?, surname: String?, middle: String?, suffix: String?, full: String?) {
        self.prefix = prefix
        self.given = given
        self.surname = surname
        self.middle = middle
        self.suffix = suffix
        self.full = full
    }
    
    /// See `ValidationSetable.setterValidations()`
    public func setterValidations() -> SetterValidations<Name> {
        var validations = SetterValidations(Name.self)
        
        validations.set(\.prefix) { prefix in
            guard let prefix = prefix else { return }
            guard prefix.count <= 140 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`prefix` property must have a length less than 140")
            }
        }
        validations.set(\.given) { given in
            guard let given = given else { return }
            guard given.count <= 140 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`prefix` property must have a length less than 140")
            }
        }
        validations.set(\.surname) { surname in
            guard let surname = surname else { return }
            guard surname.count <= 140 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`prefix` property must have a length less than 140")
            }
        }
        validations.set(\.middle) { middle in
            guard let middle = middle else { return }
            guard middle.count <= 140 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`prefix` property must have a length less than 140")
            }
        }
        validations.set(\.suffix) { suffix in
            guard let suffix = suffix else { return }
            guard suffix.count <= 140 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`prefix` property must have a length less than 140")
            }
        }
        validations.set(\.full) { full in
            guard let full = full else { return }
            guard full.count <= 300 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`prefix` property must have a length less than 140")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case prefix, surname, suffix
        case given = "given_name"
        case full = "full_name"
    }
}
