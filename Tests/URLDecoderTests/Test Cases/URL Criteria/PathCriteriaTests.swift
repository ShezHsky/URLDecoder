import URLDecoder
import XCTest

class PathCriteriaTests: XCTestCase {
    
    func testCaseSensitivePathCritera() throws {
        var decoder = URLDecoder()
        let pathCriteria: URLCriteria.Path = .matches(.caseSensitive("/must/be/in/path"))
        let urlCriteria: URLCriteria = .init(path: pathCriteria)
        decoder.urlCriteria = urlCriteria
        
        let urlWithoutPath = try XCTUnwrap(URL(string: "https://some.domain/must/be/in"))
        
        XCTAssertThrowsError(try decoder.decode(String.self, from: urlWithoutPath)) { (error) in
            let expected = URLDecodingError.criteriaUnsatisfied(urlCriteria, urlWithoutPath)
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testCaseInsensitivePathCritera_Mismatch() throws {
        var decoder = URLDecoder()
        let pathCriteria: URLCriteria.Path = .matches(.caseInsensitive("/must/be/in/path"))
        let urlCriteria: URLCriteria = .init(path: pathCriteria)
        decoder.urlCriteria = .init(path: pathCriteria)
        
        let urlWithoutPath = try XCTUnwrap(URL(string: "https://some.domain/mUsT/NOT/bE/In/pAtH"))
        
        XCTAssertThrowsError(try decoder.decode(String.self, from: urlWithoutPath)) { (error) in
            let expected = URLDecodingError.criteriaUnsatisfied(urlCriteria, urlWithoutPath)
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testCaseInsensitivePathCritera_Match() throws {
        var decoder = URLDecoder()
        let pathCriteria: URLCriteria.Path = .matches(.caseInsensitive("/must/be/in/path"))
        decoder.urlCriteria = .init(path: pathCriteria)
        
        let urlWithPath = try XCTUnwrap(URL(string: "https://some.domain/mUsT/bE/In/pAtH"))
        
        XCTAssertNoThrow(try decoder.decode(SomeDecodable.self, from: urlWithPath))
    }
    
}
