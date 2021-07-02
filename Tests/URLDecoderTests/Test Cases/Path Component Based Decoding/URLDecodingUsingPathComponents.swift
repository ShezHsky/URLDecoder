import XCTest
import URLDecoder

class URLDecodingUsingPathComponents: XCTestCase {
    
    func testDecodingSingleValue() throws {
        struct HasIdentifier: Decodable, Equatable {
            var identifier: Int
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/identifier/3"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(HasIdentifier.self, from: url)
        let expected = HasIdentifier(identifier: 3)
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingTwoValues() throws {
        struct HasIdentifierAndValue: Decodable, Equatable {
            var identifier: Int
            var value: String
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/identifier/3/value/Hello"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(HasIdentifierAndValue.self, from: url)
        let expected = HasIdentifierAndValue(identifier: 3, value: "Hello")
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingMissingValue() throws {
        struct HasIdentifier: Decodable, Equatable {
            var identifier: Int
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/identifier"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(HasIdentifier.self, from: url)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "No value found for key \"identifier\""
            )
            
            let expected = DecodingError.valueNotFound(Int.self, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testDecodingNestedMissingValue() throws {
        struct HasNestedIdentifier: Decodable, Equatable {
            
            private enum CodingKeys: String, CodingKey {
                case identifier
            }
            
            var identifier: Int
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .identifier)
                identifier = try nestedContainer.decode(Int.self, forKey: .identifier)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/identifier"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(HasNestedIdentifier.self, from: url)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "No value found for key \"identifier\""
            )
            
            let expected = DecodingError.valueNotFound(Int.self, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testDecodingNestedPresentValue() throws {
        struct HasNestedIdentifier: Decodable, Equatable {
            
            private enum CodingKeys: String, CodingKey {
                case identifier
            }
            
            var identifier: Int
            
            init(identifier: Int) {
                self.identifier = identifier
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .identifier)
                identifier = try nestedContainer.decode(Int.self, forKey: .identifier)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/identifier/42"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(HasNestedIdentifier.self, from: url)
        let expected = HasNestedIdentifier(identifier: 42)
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingNestedValueWhereKeyNotPresent() throws {
        struct HasNestedIdentifier: Decodable, Equatable {
            
            enum CodingKeys: String, CodingKey {
                case identifier
            }
            
            var identifier: Int
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .identifier)
                identifier = try nestedContainer.decode(Int.self, forKey: .identifier)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/wrong_identifier"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(HasNestedIdentifier.self, from: url)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "No query item found named \"identifier\""
            )
            
            let expected = DecodingError.keyNotFound(HasNestedIdentifier.CodingKeys.identifier, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testIndicatesKeyPresentWhenPathContainsKey() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/keyedInner/Hello"))
        
        let decoder = URLDecoder()
        let spy = try decoder.decode(DecodingSpy.self, from: url)
        
        let observedDecoder = try XCTUnwrap(spy.observedDecoder)
        let container = try observedDecoder.container(keyedBy: DecodingSpy.CodingKeys.self)
        
        XCTAssertTrue(container.contains(.keyedInner))
    }
    
    func testIndicatesKeyNotPresentWhenPathDoesNotContainKey() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/"))
        
        let decoder = URLDecoder()
        let spy = try decoder.decode(DecodingSpy.self, from: url)
        
        let observedDecoder = try XCTUnwrap(spy.observedDecoder)
        let container = try observedDecoder.container(keyedBy: DecodingSpy.CodingKeys.self)
        
        XCTAssertFalse(container.contains(.keyedInner))
    }
    
    func testDecodingNilValueUsingSingleValueContainer() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/value/%00"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(Container.self, from: url)
        
        XCTAssertTrue(decoded.value.decodedNil)
    }
    
    func testDecodingNonNilValueUsingSingleValueContainer() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/value/Hello"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(Container.self, from: url)
        
        XCTAssertFalse(decoded.value.decodedNil)
    }
    
    private struct Container: Decodable {
        
        var value: ValueWrapper
        
    }
    
    private struct ValueWrapper: Decodable {
        
        var decodedNil: Bool
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            decodedNil = container.decodeNil()
        }
        
    }
    
}
