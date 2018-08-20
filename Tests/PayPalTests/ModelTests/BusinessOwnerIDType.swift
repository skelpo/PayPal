import XCTest
@testable import PayPal

final class BusinessOwnerIDTypeTests: XCTestCase {
    struct ID: Codable {
        let type: BusinessOwner.ID.IDType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(BusinessOwner.ID.IDType.associationNumber.rawValue, "ASSOCIATION_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.businessNumber.rawValue, "BUSINESS_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.businessRegistrationNumber.rawValue, "BUSINESS_REGISTRATION_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.cnpj.rawValue, "CNPJ")
        XCTAssertEqual(BusinessOwner.ID.IDType.companyNumber.rawValue, "COMPANY_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.cooperativeNumber.rawValue, "COOPERATIVE_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.cpf.rawValue, "CPF")
        XCTAssertEqual(BusinessOwner.ID.IDType.driversLicense.rawValue, "DRIVERS_LICENSE")
        XCTAssertEqual(BusinessOwner.ID.IDType.employmentIdentificationNumber.rawValue, "EMPLOYMENT_IDENTIFICATION_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.immigrantID.rawValue, "IMMIGRANT_ID")
        XCTAssertEqual(BusinessOwner.ID.IDType.individualTaxIdentificationNumber.rawValue, "INDIVIDUAL_TAX_IDENTIFICATION_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.medicalInsuranceID.rawValue, "MEDICAL_INSURANCE_ID")
        XCTAssertEqual(BusinessOwner.ID.IDType.nationalID.rawValue, "NATIONAL_ID")
        XCTAssertEqual(BusinessOwner.ID.IDType.passportNumber.rawValue, "PASSPORT_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.socialInsuranceNumber.rawValue, "SOCIAL_INSURANCE_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.socialSecurityNumber.rawValue, "SOCIAL_SECURITY_NUMBER")
        XCTAssertEqual(BusinessOwner.ID.IDType.valueAddedTaxID.rawValue, "VALUE_ADDED_TAX_ID")
    }
    
    func testAllCase() {
        XCTAssertEqual(BusinessOwner.ID.IDType.allCases.count, 18)
        XCTAssertEqual(BusinessOwner.ID.IDType.allCases, [
            .associationNumber, .businessNumber, .businessRegistrationNumber, .cnpj, .companyNumber, .cooperativeNumber, .cpf, .driversLicense,
            .employmentIdentificationNumber, .immigrantID, .individualTaxIdentificationNumber, .medicalInsuranceID, .nationalID,
            .passportNumber, .pensionFundID, .socialInsuranceNumber, .socialSecurityNumber, .valueAddedTaxID
        ])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let associationNumber = try String(data: encoder.encode(ID(type: .associationNumber)), encoding: .utf8)
        let businessRegistrationNumber = try String(data: encoder.encode(ID(type: .businessRegistrationNumber)), encoding: .utf8)
        
        XCTAssertEqual(associationNumber, "{\"type\":\"ASSOCIATION_NUMBER\"}")
        XCTAssertEqual(businessRegistrationNumber, "{\"type\":\"BUSINESS_REGISTRATION_NUMBER\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let socialInsuranceNumber = """
        {
            "type": "SOCIAL_INSURANCE_NUMBER"
        }
        """.data(using: .utf8)!
        let valueAddedTaxID = """
        {
            "type": "VALUE_ADDED_TAX_ID"
        }
        """
        
        try XCTAssertEqual(decoder.decode(ID.self, from: socialInsuranceNumber).type, .socialInsuranceNumber)
        try XCTAssertEqual(decoder.decode(ID.self, from: valueAddedTaxID).type, .valueAddedTaxID)
    }
    
    static var allTests: [(String, (BusinessOwnerIDTypeTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}






