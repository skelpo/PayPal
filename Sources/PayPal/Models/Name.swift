import Vapor

/// The name of a person, broken into specific parts.
public struct Name: Content,  Equatable {
    
    /// The type used by the properties of the `Name` model.
    public typealias Part = Failable<String?, NotNilValidate<Length140>>
    
    /// The prefix, or title, to the party name.
    ///
    /// Maximum length: 140.
    public var prefix: Part
    
    /// The person party's given, or first, name.
    ///
    /// Maximum length: 140.
    public var given: Part
    
    /// The person party's surname or family name. Also known as the last name. Required if the party is a person.
    /// Use also to store multiple surnames including the matronymic, or mother's, surname.
    ///
    /// Maximum length: 140.
    public var surname: Part
    
    /// The person party's middle name. Use also to store multiple middle names including the patronymic, or father's, middle name.
    ///
    /// Maximum length: 140.
    public var middle: Part
    
    /// The suffix for the party's name.
    ///
    /// Maximum length: 140.
    public var suffix: Part
    
    /// The person party's full name.
    ///
    /// Maximum length: 300.
    public var full: Failable<String?, NotNilValidate<Length300>>
    
    
    /// Creates a new `Name` instance.
    ///
    /// - Parameters:
    ///   - prefix: The prefix, or title, to the party name.
    ///   - given: The person party's given, or first, name.
    ///   - surname: The person party's surname or family name.
    ///   - middle: The person party's middle name.
    ///   - suffix: The suffix for the party's name.
    ///   - full: The person party's full name.
    public init(prefix: Part, given: Part, surname: Part, middle: Part, suffix: Part, full: Failable<String?, NotNilValidate<Length300>>) {
        self.prefix = prefix
        self.given = given
        self.surname = surname
        self.middle = middle
        self.suffix = suffix
        self.full = full
    }
    
    enum CodingKeys: String, CodingKey {
        case prefix, surname, suffix
        case given = "given_name"
        case middle = "middle_name"
        case full = "full_name"
    }
}
