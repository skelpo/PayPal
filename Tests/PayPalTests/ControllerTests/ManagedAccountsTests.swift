import XCTest
import Vapor
@testable import PayPal

final class ManagedAccountsTests: XCTestCase {
    
    var app: Application!
    var id: String?
    
    override func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
        
        let identity = try! self.app.make(Identity.self)
        self.id = try! identity.info().wait().payerID
    }
    
    func testServiceExists()throws {
        _ = try app.make(ManagedAccounts.self)
    }
    
    func testCreateEndpoint()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "ID is nil")
        }
        
        let paymentPref = try PaymentReceivingPreferences(
            blockUnconfirmedUSAddress: true,
            blockNonUS: false,
            blockEcheck: false,
            blockCrossCurrency: true,
            blockSendMoney: false,
            alternatePayment: "https://example.com/alternate",
            displayInstructionsInput: true,
            ccDescriptor: nil,
            ccDescriptorExtended: nil
        )
        let business = try Business(
            type: .individual,
            subType: .unselected,
            government: GovernmentBody(name: ""),
            establishment: Establishment(state: "KS", country: "US"),
            names: [],
            ids: [],
            phones: [],
            category: "3145",
            subCategory: "5972",
            merchantCategory: "4653",
            establishedDate: TimelessDate(date: "1882-05-13"),
            registrationDate: TimelessDate(date: "1975-04-22"),
            disputeEmail: EmailAddress(email: "disputable@exmaple.com"),
            sales: .init(
                price: MoneyRange("50"..."60", currency: .usd),
                volume: MoneyRange("50"..."60", currency: .usd),
                venues: [],
                website: "https://example.com",
                online: PercentRange(0...1)
            ),
            customerService: CustomerService(
                email: EmailAddress(email: "help@nameless.com"),
                phone: PhoneNumber(country: "1", number: "9963191901"),
                message: []
            ),
            addresses: [],
            country: "US",
            stakeholders: [],
            designation: .init(title: "CTO", area: "Software Engineering")
        )
        let owner = try BusinessOwner(
            email: "business@example.com",
            name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"),
            relationships: [],
            country: "UK",
            addresses: [],
            birthdate: "1771-08-15",
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        
        let account = try MerchantAccount(
            owner: owner,
            business: business,
            status: .a,
            currency: .usd,
            seconderyCurrencies: [.eur],
            paymentReceiving: paymentPref,
            relations: [AccountRelation(type: .same, payer: id)],
            permissions: [AccountPermission(thirdParty: nil, permissions: [.directPayment])],
            timezone: .chicago,
            partnerExternalID: nil,
            loginable: true,
            partnerTaxReporting: false,
            signupOptions: nil,
            errors: nil,
            financialInstruments: FinancialInstruments(instruments: [FinancialInstrument(accountType: .checking)])
        )
        
        let accounts = try self.app.make(ManagedAccounts.self)
        let created = try accounts.create(account: account).wait()
        
        XCTAssertEqual(created.errors?.count, 0)
    }
    
    func testPatchEndpoint()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "ID is nil")
        }
        
        let instrument = FinancialInstrument(accountType: .saving)
        let patch: Patch = try Patch(operation: .add, path: "/financial_instruments", value: [instrument].json(), from: nil)
        let accounts = try self.app.make(ManagedAccounts.self)
        let status = try accounts.patch(account: id, with: [patch]).wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    static var allTests: [(String, (ManagedAccountsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testPatchEndpoint", testPatchEndpoint)
    ]
}

