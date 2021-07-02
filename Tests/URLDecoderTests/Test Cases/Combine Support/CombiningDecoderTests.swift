#if canImport(Combine)

import Combine
import XCTest
import URLDecoder

class CombiningDecoderTests: XCTestCase {
    
    func testCanCombineDecoderWithUpstream() throws {
        struct HasIdentifier: Decodable, Equatable {
            var identifier: String
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/path?identifier=Hello"))
        let upstream = Just(url)
        
        var decodedValue: HasIdentifier?
        let cancellable = upstream
            .decode(type: HasIdentifier.self, decoder: URLDecoder())
            .sink(receiveCompletion: { (_) in }, receiveValue: { decodedValue = $0 })
        
        let expected = HasIdentifier(identifier: "Hello")
        XCTAssertEqual(expected, decodedValue)
        
        cancellable.cancel()
    }
    
}

#endif
