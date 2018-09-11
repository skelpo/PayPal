import Vapor

public struct PaymentReceivingPreferences: Content, Equatable {
    public var blockUnconfirmedUSAddress: Bool?
    public var blockNonUS: Bool?
    public var blockEcheck: Bool?
    public var blockCrossCurrency: Bool?
    public var blockSendMoney: Bool?
    public var alternatePayment: String?
    public var displayInstructionsInput: Bool?
    public var ccDescriptor: String?
    public var ccDescriptorExtended: String?
    
    public init(
        blockUnconfirmedUSAddress: Bool?,
        blockNonUS: Bool?,
        blockEcheck: Bool?,
        blockCrossCurrency: Bool?,
        blockSendMoney: Bool?,
        alternatePayment: String?,
        displayInstructionsInput: Bool?,
        ccDescriptor: String?,
        ccDescriptorExtended: String?
    )throws {
        self.blockUnconfirmedUSAddress = blockUnconfirmedUSAddress
        self.blockNonUS = blockNonUS
        self.blockEcheck = blockEcheck
        self.blockCrossCurrency = blockCrossCurrency
        self.blockSendMoney = blockSendMoney
        self.alternatePayment = alternatePayment
        self.displayInstructionsInput = displayInstructionsInput
        self.ccDescriptor = ccDescriptor
        self.ccDescriptorExtended = ccDescriptorExtended
    }
}
