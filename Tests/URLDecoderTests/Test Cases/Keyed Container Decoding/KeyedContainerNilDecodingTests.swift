import URLDecoder
import XCTest

class KeyedContainerNilDecodingTests: XCTestCase {
    
    func testDecodingNilFromPresentKey() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/argument/Hello"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(DecodesNil.self, from: url)
        
        XCTAssertFalse(decoded.decodedNil)
    }
    
    func testDecodingNonNilFromPresentKey() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/argument/%00"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(DecodesNil.self, from: url)
        
        XCTAssertTrue(decoded.decodedNil)
    }
    
    func testAttemptingToDecodeNilFromMissingKey() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/someOtherArgument/Hello"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(DecodesNil.self, from: url)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "No query item found named \"argument\""
            )
            
            let expected = DecodingError.keyNotFound(DecodesNil.CodingKeys.argument, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    private struct DecodesNil: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case argument
        }
        
        var decodedNil: Bool
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            decodedNil = try container.decodeNil(forKey: .argument)
        }
        
    }
    
}
