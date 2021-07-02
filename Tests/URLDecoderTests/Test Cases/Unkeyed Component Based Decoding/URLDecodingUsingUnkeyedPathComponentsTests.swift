import URLDecoder
import XCTest

class URLDecodingUsingUnkeyedPathComponentsTests: XCTestCase {
    
    func testDecodingEveryTypeUnderTheSun() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/true/Hello/1/2/3/4/5/6/7/8/9/10/11/12"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(EverySupportedNativeDecodableTypeUsingUnkeyedContainerDecoding.self, from: url)
        let expected = EverySupportedNativeDecodableTypeUsingUnkeyedContainerDecoding(
            boolValue: true,
            stringValue: "Hello",
            doubleValue: 1,
            floatValue: 2,
            intValue: 3,
            int8Value: 4,
            int16Value: 5,
            int32Value: 6,
            int64Value: 7,
            uintValue: 8,
            uint8Value: 9,
            uint16Value: 10,
            uint32Value: 11,
            uint64Value: 12
        )
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingEveryOptionalTypeUnderTheSun() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(EverySupportedOptionalNativeDecodableTypeUsingUnkeyedContainerDecoding.self, from: url)
        let expected = EverySupportedOptionalNativeDecodableTypeUsingUnkeyedContainerDecoding()
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingIncrementsCurrentIndex() throws {
        struct ContainsSeveralProperties: Decodable {
            
            var witnessedIndicies: [Int] = []
            
            init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()
                witnessedIndicies.append(container.currentIndex)
                
                _ = try container.decode(String.self)
                witnessedIndicies.append(container.currentIndex)
                
                _ = try container.decode(String.self)
                witnessedIndicies.append(container.currentIndex)
                
                _ = try container.decode(String.self)
                witnessedIndicies.append(container.currentIndex)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/First/Second/Third"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(ContainsSeveralProperties.self, from: url)
        
        let expectedIndicies = [0, 1, 2, 3]
        XCTAssertEqual(expectedIndicies, decoded.witnessedIndicies)
    }
    
    func testDecodingKnowsCountUsingPathBasedArguments() throws {
        struct UnkeyedContainerSpy: Decodable {
            
            var container: UnkeyedDecodingContainer
            
            init(from decoder: Decoder) throws {
                container = try decoder.unkeyedContainer()
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/First/Second/Third"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(UnkeyedContainerSpy.self, from: url)
        
        XCTAssertEqual(3, decoded.container.count)
    }
    
    func testDecodingIndicatesAtEndWhenNothingLeftToDecode() throws {
        struct AssertDecoderReachesEndWhenNothingLeft: Decodable {
            
            var isAtEndStates: [Bool] = []
            
            init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()
                isAtEndStates.append(container.isAtEnd)
                
                _ = try container.decode(String.self)
                isAtEndStates.append(container.isAtEnd)
                
                _ = try container.decode(String.self)
                isAtEndStates.append(container.isAtEnd)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/First/Second"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(AssertDecoderReachesEndWhenNothingLeft.self, from: url)
        
        let expected = [false, false, true]
        XCTAssertEqual(expected, decoded.isAtEndStates)
    }
    
    func testDecodingCustomTypePropogatesUserInfo() throws {
        struct DecodesUnkeyedType: Decodable {
            
            struct UsesNestedDecoder: Decodable {
                
                var decoder: Decoder
                
                init(from decoder: Decoder) throws {
                    self.decoder = decoder
                }
                
            }
            
            var usesNestedDecoder: UsesNestedDecoder
            
            init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()
                usesNestedDecoder = try container.decode(UsesNestedDecoder.self)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/Hello"))
        var decoder = URLDecoder()
        let userInfo: [CodingUserInfoKey: String] = [CodingUserInfoKey(rawValue: "key")!: "value"]
        decoder.userInfo = userInfo
        let decoded = try decoder.decode(DecodesUnkeyedType.self, from: url)
        let capturedDecoder = decoded.usesNestedDecoder.decoder
        
        XCTAssertEqual(userInfo, try XCTUnwrap(capturedDecoder.userInfo as? [CodingUserInfoKey: String]))
    }
    
    func testAttemptingToDecoderMoreValuesThanExistsInContainer() throws {
        struct TriesDecodingMoreValuesThanItShould: Decodable {
            
            init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()
                _ = try container.decode(Int.self)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(TriesDecodingMoreValuesThanItShould.self, from: url)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "Unkeyed container is at end."
            )
            
            let expectedError = DecodingError.valueNotFound(Int.self, expectedContext)
            
            assertExpectedDecodingError(expectedError, equals: error)
        }
    }
    
    func testDecodingNilThenNonNilValues_OptionalArgumentIsNil() throws {
        struct DecodesNilThenNonNil: Decodable, Equatable {
            
            var optionalString: String?
            var nonOptionalString: String
            
            init(optionalString: String?, nonOptionalString: String) {
                self.optionalString = optionalString
                self.nonOptionalString = nonOptionalString
            }
            
            init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()
                
                if try container.decodeNil() == false {
                    optionalString = try container.decode(String.self)
                }
                
                nonOptionalString = try container.decode(String.self)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/%00/Hello"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(DecodesNilThenNonNil.self, from: url)
        let expected = DecodesNilThenNonNil(optionalString: nil, nonOptionalString: "Hello")
        
        XCTAssertEqual(decoded, expected)
    }
    
    func testDecodingNilThenNonNilValues_OptionalArgumentIsNotNil() throws {
        struct DecodesNilThenNonNil: Decodable, Equatable {
            
            var optionalString: String?
            var nonOptionalString: String
            
            init(optionalString: String?, nonOptionalString: String) {
                self.optionalString = optionalString
                self.nonOptionalString = nonOptionalString
            }
            
            init(from decoder: Decoder) throws {
                var container = try decoder.unkeyedContainer()
                
                if try container.decodeNil() == false {
                    optionalString = try container.decode(String.self)
                }
                
                nonOptionalString = try container.decode(String.self)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/Hello/World"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(DecodesNilThenNonNil.self, from: url)
        let expected = DecodesNilThenNonNil(optionalString: "Hello", nonOptionalString: "World")
        
        XCTAssertEqual(decoded, expected)
    }
    
    func testDecodingSingleStringElement() throws {
        try assertDecodingUnkeyedValue("book")
    }
    
    func testDecodingSingleIntElement() throws {
        try assertDecodingUnkeyedValue(42)
    }
    
    func testDecodingNestedUnkeyedContainer() throws {
        struct HasUnkeyedElements: Decodable, Equatable {
            
            private enum CodingKeys: String, CodingKey {
                case key
            }
            
            var first: String
            var second: String
            
            init(first: String, second: String) {
                self.first = first
                self.second = second
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                var childContainer = try container.nestedUnkeyedContainer(forKey: .key)
                first = try childContainer.decode(String.self)
                second = try childContainer.decode(String.self)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/key/first/second"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(HasUnkeyedElements.self, from: url)
        let expected = HasUnkeyedElements(first: "first", second: "second")
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingNestedUnkeyedContainer_KeyMissing() throws {
        struct HasUnkeyedElements: Decodable, Equatable {
            
            enum CodingKeys: String, CodingKey {
                case key
            }
            
            var first: String
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                var childContainer = try container.nestedUnkeyedContainer(forKey: .key)
                first = try childContainer.decode(String.self)
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/wrong_key/first"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(HasUnkeyedElements.self, from: url)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "No query item found named \"key\""
            )
            
            let expectedError = DecodingError.keyNotFound(HasUnkeyedElements.CodingKeys.key, expectedContext)
            
            assertExpectedDecodingError(expectedError, equals: error)
        }
    }
    
    private func assertDecodingUnkeyedValue<T>(_ value: T, line: UInt = #line) throws where T: Decodable & Equatable {
        let url = try XCTUnwrap(URL(string: "https://some.domain/\(String(describing: value))"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(DecodesOneUnkeyedComponent<T>.self, from: url)
        let expected = DecodesOneUnkeyedComponent(argument: value)
        
        XCTAssertEqual(expected, decoded, line: line)
    }
    
    private struct DecodesOneUnkeyedComponent<T>: Decodable, Equatable where T: Decodable & Equatable {
        
        var argument: T
        
        init(argument: T) {
            self.argument = argument
        }
        
        init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            self.argument = try container.decode(T.self)
        }
        
    }
    
    private func assertDecodingMismatchedTypeForSingleValueQueryParameter<Attempted, Unexpected>(
        attempted: Attempted.Type,
        value: Unexpected,
        line: UInt = #line
    ) throws where Attempted: Decodable & Equatable, Unexpected: Decodable & Equatable {
        let url = try XCTUnwrap(URL(string: "https://some.domain/\(String(describing: value))"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(UnkeyedDecodableContainer<Attempted>.self, from: url), line: line) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "Unable to decode value \"\(String(describing: value))\" into type \(String(describing: Attempted.self))"
            )
            
            let expected = DecodingError.typeMismatch(Attempted.self, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error, line: line)
        }
    }
    
    struct UnkeyedDecodableContainer<T>: Decodable, Equatable where T: Decodable & Equatable {
        
        var argument: T
        
        init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            argument = try container.decode(T.self)
        }
        
    }
    
}
