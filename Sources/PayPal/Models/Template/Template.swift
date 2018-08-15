import Vapor

public struct Template: Content, Equatable {
    public let id: String?
    public let custom: Bool?
    public let links: [LinkDescription]?
    
    public var name: String?
    public var `default`: Bool?
    public var data: Data?
    public var settings: [Settings]?
    public var measureUnit: Invoice.Measure?
    
    public init(name: String?, default: Bool?, data: Data?, settings: [Settings]?, measureUnit: Invoice.Measure?) {
        self.id = nil
        self.custom = nil
        self.links = nil
        
        self.name = name
        self.default = `default`
        self.data = data
        self.settings = settings
        self.measureUnit = measureUnit
    }
}
