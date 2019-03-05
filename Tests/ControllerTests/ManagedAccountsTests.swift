import XCTest
import Vapor
@testable import PayPal

public final class ManagedAccountsTests: XCTestCase {
    
    var app: Application!
    var id: String?
    
    override public func setUp() {
        super.setUp()
        setPaypalVars()
        
        var services = Services.default()
        try! services.register(PayPalProvider())
        
        app = try! Application.testable(services: services)
        
        do {
            let identity = try self.app.make(Identity.self)
            self.id = try identity.info().wait().payerID
        } catch let error {
            fatalError(String(describing: error))
        }
    }
    
    func testServiceExists()throws {
        _ = try app.make(ManagedAccounts.self)
    }
    
    func testCreateEndpoint()throws {        
        let paymentPref = PaymentReceivingPreferences(
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
            establishment: Establishment(state: .ks, country: .unitedStates),
            names: [],
            ids: [],
            phones: [],
            category: .init("3145"),
            subCategory: .init("5972"),
            merchantCategory: .init("4653"),
            establishedDate: TimelessDate(date: "1882-05-13"),
            registrationDate: TimelessDate(date: "2000-04-22"),
            disputeEmail: EmailAddress(email: "disputable@exmaple.com"),
            sales: .init(
                price: MoneyRange(50...60, currency: .usd),
                volume: MoneyRange(50...60, currency: .usd),
                venues: [],
                website: .init("https://example.com"),
                online: PercentRange(0...1)
            ),
            customerService: CustomerService(
                email: .init("help@nameless.com"),
                phone: PhoneNumber(country: .init(1), number: .init(9963191901)),
                message: []
            ),
            addresses: [],
            country: .unitedStates,
            stakeholders: [],
            designation: .init(title: "CTO", area: "Software Engineering")
        )
        let owner = try BusinessOwner(
            email: "business@example.com",
            name: Name(
                prefix: .init("Sir"), given: .init("Walter"), surname: .init("Scott"), middle: nil, suffix: .init("Bart."), full: nil
            ),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: Date(),
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        
        let account = MerchantAccount(
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
    
    func testUpdateEndpoint()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "ID is nil")
        }
        
        let paymentPref = PaymentReceivingPreferences(
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
            establishment: Establishment(state: .ks, country: .unitedStates),
            names: [],
            ids: [],
            phones: [],
            category: .init("3145"),
            subCategory: .init("5972"),
            merchantCategory: .init("4653"),
            establishedDate: TimelessDate(date: "1882-05-13"),
            registrationDate: TimelessDate(date: "1975-04-22"),
            disputeEmail: EmailAddress(email: "disputable@exmaple.com"),
            sales: .init(
                price: MoneyRange(50...60, currency: .usd),
                volume: MoneyRange(50...60, currency: .usd),
                venues: [],
                website: .init("https://example.com"),
                online: PercentRange(0...1)
            ),
            customerService: CustomerService(
                email: .init("help@nameless.com"),
                phone: PhoneNumber(country: .init(1), number: .init(9963191901)),
                message: []
            ),
            addresses: [],
            country: .unitedStates,
            stakeholders: [],
            designation: .init(title: "CTO", area: "Software Engineering")
        )
        let owner = try BusinessOwner(
            email: "business@example.com",
            name: Name(
                prefix: .init("Sir"), given: .init("Walter"), surname: .init("Scott"), middle: nil, suffix: .init("Bart."),
                full: .init("Sir Walter Scott")
            ),
            relationships: [],
            country: .unitedKingdom,
            addresses: [],
            birthdate: Date(),
            language: .en_GB,
            phones: [],
            ids: [],
            occupation: "Author"
        )
        
        let account = MerchantAccount(
            owner: owner,
            business: business,
            status: .a,
            currency: .usd,
            seconderyCurrencies: [.eur],
            paymentReceiving: paymentPref,
            relations: [AccountRelation(type: .same, payer: id)],
            permissions: [AccountPermission(thirdParty: nil, permissions: [.directPayment])],
            timezone: .denver,
            partnerExternalID: nil,
            loginable: true,
            partnerTaxReporting: false,
            signupOptions: nil,
            errors: nil,
            financialInstruments: FinancialInstruments(instruments: [FinancialInstrument(accountType: .checking)])
        )
        
        let accounts = try self.app.make(ManagedAccounts.self)
        let status = try accounts.update(account: id, with: account).wait()
        
        XCTAssertEqual(status, .noContent)
    }
    
    func testDetailsEndpoint()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "ID is nil")
        }
        
        let accounts = try self.app.make(ManagedAccounts.self)
        let details = try accounts.details(for: id).wait()
        
        XCTAssert(details.relations?.contains { $0.payer == id } ?? false)
    }
    
    func testBalanceEndpoint()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "ID is nil")
        }
        
        let accounts = try self.app.make(ManagedAccounts.self)
        let balance = try accounts.balance(for: id).wait()
        
        XCTAssertEqual(balance.payer, id)
    }
    
    func testInstrumentsEndpoint()throws {
        guard let id = self.id else {
            throw Abort(.internalServerError, reason: "ID is nil")
        }
        
        let accounts = try self.app.make(ManagedAccounts.self)
        let instruments = try accounts.financialInstruments(for: id).wait()
        
        XCTAssertGreaterThan(instruments.instruments?.count ?? 0, 0)
    }
    
    public static var allTests: [(String, (ManagedAccountsTests) -> ()throws -> ())] = [
        ("testServiceExists", testServiceExists),
        ("testCreateEndpoint", testCreateEndpoint),
        ("testPatchEndpoint", testPatchEndpoint),
        ("testUpdateEndpoint", testUpdateEndpoint),
        ("testDetailsEndpoint", testDetailsEndpoint),
        ("testBalanceEndpoint", testBalanceEndpoint),
        ("testInstrumentsEndpoint", testInstrumentsEndpoint)
    ]
}

