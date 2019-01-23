import XCTest
import Failable
@testable import PayPal

final class BusinessTests: XCTestCase {
    func testInit()throws {
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
                website: .init("https://nameless.io"),
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
        
        XCTAssertEqual(business.type, .individual)
        XCTAssertEqual(business.subType, .unselected)
        XCTAssertEqual(business.government, GovernmentBody(name: ""))
        XCTAssertEqual(business.names, [])
        XCTAssertEqual(business.ids, [])
        XCTAssertEqual(business.phones, [])
        XCTAssertEqual(business.category.value, "3145")
        XCTAssertEqual(business.subCategory.value, "5972")
        XCTAssertEqual(business.merchantCategory.value, "4653")
        XCTAssertEqual(business.addresses, [])
        XCTAssertEqual(business.country, .unitedStates)
        XCTAssertEqual(business.stakeholders, [])
        XCTAssertEqual(business.designation, Business.Designation(title: "CTO", area: "Software Engineering"))
        
        XCTAssertEqual(business.establishment, Establishment(state: .ks, country: .unitedStates))
        XCTAssertEqual(business.establishedDate, TimelessDate(date: "1882-05-13"))
        XCTAssertEqual(business.registrationDate, TimelessDate(date: "1975-04-22"))
        try XCTAssertEqual(business.disputeEmail, EmailAddress(email: .init("disputable@exmaple.com")))
        try XCTAssertEqual(business.sales, Business.Sales.init(
            price: MoneyRange(50...60, currency: .usd),
            volume: MoneyRange(50...60, currency: .usd),
            venues: [],
            website: .init("https://nameless.io"),
            online: PercentRange(0...1)
        ))
    }
    
    func testValueValidation()throws {
        var business = try Business(
            type: .individual,
            subType: nil,
            government: nil,
            establishment: nil,
            names: [],
            ids: [],
            phones: [],
            category: .init("3145"),
            subCategory: .init("5972"),
            merchantCategory: .init("4653"),
            establishedDate: nil,
            registrationDate: nil,
            disputeEmail: nil,
            sales: nil,
            customerService: nil,
            addresses: [],
            country: nil,
            stakeholders: [],
            designation: nil
        )
        
        try XCTAssertThrowsError(business.category <~ "314")
        try XCTAssertThrowsError(business.subCategory <~ "59726")
        try XCTAssertThrowsError(business.merchantCategory <~ "463")
        try business.category <~ "3145"
        try business.subCategory <~ "5972"
        try business.merchantCategory <~ "4653"
        
        XCTAssertEqual(business.category.value, "3145")
        XCTAssertEqual(business.subCategory.value, "5972")
        XCTAssertEqual(business.merchantCategory.value, "4653")
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let business = try Business(
            type: .individual,
            subType: .unselected,
            government: GovernmentBody(name: nil),
            establishment: Establishment(state: nil, country: nil),
            names: [],
            ids: [],
            phones: [],
            category: .init("3145"),
            subCategory: .init("5972"),
            merchantCategory: .init("4653"),
            establishedDate: TimelessDate(date: nil),
            registrationDate: TimelessDate(date: nil),
            disputeEmail: nil,
            sales: .init(
                price: nil,
                volume: nil,
                venues: nil,
                website: nil,
                online: nil
            ),
            customerService: CustomerService(
                email: .init("help@nameless.com"),
                phone: nil,
                message: nil
            ),
            addresses: [],
            country: .unitedStates,
            stakeholders: [],
            designation: .init(title: nil, area: nil)
        )
        
        let generated = try String(data: encoder.encode(business), encoding: .utf8)!
        let json =
            "{\"category\":\"3145\",\"sub_type\":\"UNSELECTED\",\"addresses\":[],\"sub_category\":\"5972\",\"names\":[]," +
            "\"business_sales_details\":{},\"phones\":[],\"government_body\":{},\"type\":\"INDIVIDUAL\",\"identifications\":[]," +
            "\"country_code_of_incorporation\":\"US\",\"stakeholders\":[],\"customer_service\":{\"email\":\"help@nameless.com\"}," +
            "\"designation\":{},\"merchant_category_code\":\"4653\",\"place_of_establishment\":{}}"
        
        var index = 0
        for (jsonChar, genChar) in zip(json, generated) {
            if jsonChar == genChar { index += 1; continue }
            XCTAssertEqual(jsonChar, genChar, "values don't match. Failure starts at index \(index)")
            break
        }
        
        XCTAssertEqual(generated, json)
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let json = """
        {
            "type": "INDIVIDUAL",
            "sub_type": "UNSELECTED",
            "government_body": {},
            "place_of_establishment": {},
            "names": [],
            "identifications": [],
            "phones": [],
            "category": "3145",
            "sub_category": "5972",
            "merchant_category_code": "4653",
            "dispute_email": null,
            "business_sales_details": {},
            "customer_service": {
                "email": "help@nameless.com"
            },
            "addresses": [],
            "country_code_of_incorporation": "US",
            "stakeholders": [],
            "designation": {}
        }
        """.data(using: .utf8)!
        
        try XCTAssertEqual(
            Business(
                type: .individual,
                subType: .unselected,
                government: GovernmentBody(name: nil),
                establishment: Establishment(state: nil, country: nil),
                names: [],
                ids: [],
                phones: [],
                category: .init("3145"),
                subCategory: .init("5972"),
                merchantCategory: .init("4653"),
                establishedDate: TimelessDate(date: nil),
                registrationDate: TimelessDate(date: nil),
                disputeEmail: nil,
                sales: .init(
                    price: nil,
                    volume: nil,
                    venues: nil,
                    website: nil,
                    online: nil
                ),
                customerService: CustomerService(
                    email: .init("help@nameless.com"),
                    phone: nil,
                    message: nil
                ),
                addresses: [],
                country: .unitedStates,
                stakeholders: [],
                designation: .init(title: nil, area: nil)
            ),
            decoder.decode(Business.self, from: json)
        )
    }
    
    static var allTests: [(String, (BusinessTests) -> ()throws -> ())] = [
        ("testInit", testInit),
        ("testValueValidation", testValueValidation),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}

