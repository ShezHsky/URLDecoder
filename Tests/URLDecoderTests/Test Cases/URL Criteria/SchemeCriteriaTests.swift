import URLDecoder
import XCTest

class SchemeCriteriaTests: XCTestCase {
    
    func testMatchesSchemeCriteria() throws {
        var decoder = URLDecoder()
        let schemeCriteria: URLCriteria.Scheme = .matches("https")
        let urlCriteria: URLCriteria = .init(scheme: schemeCriteria)
        decoder.urlCriteria = urlCriteria
        
        let urlWithoutUnsecureScheme = try XCTUnwrap(URL(string: "http://some.other.domain"))
        
        XCTAssertThrowsError(try decoder.decode(String.self, from: urlWithoutUnsecureScheme)) { (error) in
            let expected = URLDecodingError.criteriaUnsatisfied(urlCriteria, urlWithoutUnsecureScheme)
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testMatchesSchemeCriteriaIgnoringCaseSensitivity() throws {
        var decoder = URLDecoder()
        let schemeCriteria: URLCriteria.Scheme = .matches("https")
        let urlCriteria: URLCriteria = .init(scheme: schemeCriteria)
        decoder.urlCriteria = urlCriteria
        
        let urlWithScheme = try XCTUnwrap(URL(string: "hTtPs://some.other.domain"))
        
        XCTAssertNoThrow(try decoder.decode(SomeDecodable.self, from: urlWithScheme))
    }
    
    func testMustMatchIsStrictWithPartalSchemes() throws {
        var decoder = URLDecoder()
        let schemeCriteria: URLCriteria.Scheme = .matches("http")
        let urlCriteria: URLCriteria = .init(scheme: schemeCriteria)
        decoder.urlCriteria = urlCriteria
        
        let urlWithSecureScheme = try XCTUnwrap(URL(string: "https://some.other.domain"))
        
        XCTAssertThrowsError(try decoder.decode(String.self, from: urlWithSecureScheme)) { (error) in
            let expected = URLDecodingError.criteriaUnsatisfied(urlCriteria, urlWithSecureScheme)
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
}
