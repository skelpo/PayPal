import XCTest
@testable import PayPal

public final class BusinessOwnerIDTypeTests: XCTestCase {
    struct ID: Codable {
        let type: Identification.IDType
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Identification.IDType.associationNumber.rawValue, "ASSOCIATION_NUMBER")
        XCTAssertEqual(Identification.IDType.businessNumber.rawValue, "BUSINESS_NUMBER")
        XCTAssertEqual(Identification.IDType.businessRegistrationNumber.rawValue, "BUSINESS_REGISTRATION_NUMBER")
        XCTAssertEqual(Identification.IDType.cnpj.rawValue, "CNPJ")
        XCTAssertEqual(Identification.IDType.companyNumber.rawValue, "COMPANY_NUMBER")
        XCTAssertEqual(Identification.IDType.cooperativeNumber.rawValue, "COOPERATIVE_NUMBER")
        XCTAssertEqual(Identification.IDType.cpf.rawValue, "CPF")
        XCTAssertEqual(Identification.IDType.driversLicense.rawValue, "DRIVERS_LICENSE")
        XCTAssertEqual(Identification.IDType.employmentIdentificationNumber.rawValue, "EMPLOYMENT_IDENTIFICATION_NUMBER")
        XCTAssertEqual(Identification.IDType.immigrantID.rawValue, "IMMIGRANT_ID")
        XCTAssertEqual(Identification.IDType.individualTaxIdentificationNumber.rawValue, "INDIVIDUAL_TAX_IDENTIFICATION_NUMBER")
        XCTAssertEqual(Identification.IDType.medicalInsuranceID.rawValue, "MEDICAL_INSURANCE_ID")
        XCTAssertEqual(Identification.IDType.nationalID.rawValue, "NATIONAL_ID")
        XCTAssertEqual(Identification.IDType.passportNumber.rawValue, "PASSPORT_NUMBER")
        XCTAssertEqual(Identification.IDType.socialInsuranceNumber.rawValue, "SOCIAL_INSURANCE_NUMBER")
        XCTAssertEqual(Identification.IDType.socialSecurityNumber.rawValue, "SOCIAL_SECURITY_NUMBER")
        XCTAssertEqual(Identification.IDType.valueAddedTaxID.rawValue, "VALUE_ADDED_TAX_ID")
    }
    
    func testAllCase() {
        XCTAssertEqual(Identification.IDType.allCases.count, 18)
        XCTAssertEqual(Identification.IDType.allCases, [
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






