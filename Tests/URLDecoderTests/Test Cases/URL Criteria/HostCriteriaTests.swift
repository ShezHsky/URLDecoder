import URLDecoder
import XCTest

class HostCriteriaTests: XCTestCase {
    
    func testMatchesHostCriteria() throws {
        var decoder = URLDecoder()
        let hostCriteria: URLCriteria.Host = .matches("my.domain")
        let urlCriteria: URLCriteria = .init(host: hostCriteria)
        decoder.urlCriteria = urlCriteria
        
        let urlWithoutHost = try XCTUnwrap(URL(string: "https://some.other.domain"))
        
        XCTAssertThrowsError(try decoder.decode(String.self, from: urlWithoutHost)) { (error) in
            let expected = URLDecodingError.criteriaUnsatisfied(urlCriteria, urlWithoutHost)
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testMatchesHostCriteriaIgnoringCaseSensitivity() throws {
        var decoder = URLDecoder()
        let hostCriteria: URLCriteria.Host = .matches("my.domain")
        let urlCriteria: URLCriteria = .init(host: hostCriteria)
        decoder.urlCriteria = urlCriteria
        
        let urlWithHost = try XCTUnwrap(URL(string: "https://mY.dOmAiN"))
        
        XCTAssertNoThrow(try decoder.decode(SomeDecodable.self, from: urlWithHost))
    }
    
    func testMustMatchIsStrictWithSubDomains() throws {
        var decoder = URLDecoder()
        let hostCriteria: URLCriteria.Host = .matches("my.domain")
        let urlCriteria: URLCriteria = .init(host: hostCriteria)
        decoder.urlCriteria = urlCriteria
        
        let urlWithSubdomain = try XCTUnwrap(URL(string: "https://my.domain.subdomain"))
        
        XCTAssertThrowsError(try decoder.decode(String.self, from: urlWithSubdomain)) { (error) in
            let expected = URLDecodingError.criteriaUnsatisfied(urlCriteria, urlWithSubdomain)
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
}
