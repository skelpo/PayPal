import XCTest
@testable import PayPal

fileprivate typealias Tax = Order.Payer.TaxType

public final class OrderPayerTaxTests: XCTestCase {
    private struct Pay: Codable {
        let tax: Tax
    }
    
    func testCaseRawValues() {
        XCTAssertEqual(Tax.cpf.rawValue, "BR_CPF")
        XCTAssertEqual(Tax.cnpj.rawValue, "BR_CNPJ")
    }
    
    func testAllCase() {
        XCTAssertEqual(Tax.allCases.count, 2)
        XCTAssertEqual(Tax.allCases, [.cpf, .cnpj])
    }
    
    func testEncoding()throws {
        let encoder = JSONEncoder()
        let cpf = try String(data: encoder.encode(Pay(tax: .cpf)), encoding: .utf8)
        let cnpj = try String(data: encoder.encode(Pay(tax: .cnpj)), encoding: .utf8)
        
        XCTAssertEqual(cpf, "{\"tax\":\"BR_CPF\"}")
        XCTAssertEqual(cnpj, "{\"tax\":\"BR_CNPJ\"}")
    }
    
    func testDecoding()throws {
        let decoder = JSONDecoder()
        let cpf = """
        {
            "tax": "BR_CPF"
        }
        """.data(using: .utf8)!
        let cnpj = """
        {
            "tax": "BR_CNPJ"
        }
        """
        
        try XCTAssertEqual(decoder.decode(Pay.self, from: cpf).tax, .cpf)
        try XCTAssertEqual(decoder.decode(Pay.self, from: cnpj).tax, .cnpj)
    }
    
    public static var allTests: [(String, (OrderPayerTaxTests) -> ()throws -> ())] = [
        ("testCaseRawValues", testCaseRawValues),
        ("testAllCase", testAllCase),
        ("testEncoding", testEncoding),
        ("testDecoding", testDecoding)
    ]
}








