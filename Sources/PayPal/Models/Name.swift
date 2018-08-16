import Vapor

/// The name of a person, broken into specific parts.
public struct Name: Content, Equatable {
    
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
}
