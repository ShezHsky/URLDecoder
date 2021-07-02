import XCTest
import URLDecoder

class URLDecodingUsingQueryItemsTests: XCTestCase {
    
    private var decoder: URLDecoder!
    
    override func setUp() {
        super.setUp()
        decoder = URLDecoder()
    }
    
    func testQueryItemNotPresentThrowsKeyMissingError() throws {
        struct DecodesArgument: Decodable {
            
            enum CodingKeys: String, CodingKey {
                case argument
            }
            
            var argument: String
            
        }
        
        let urlWithoutArgument = try URLBuilder.buildURL()
        XCTAssertThrowsError(try decoder.decode(DecodesArgument.self, from: urlWithoutArgument)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "No query item found named \"argument\""
            )
            
            let expected = DecodingError.keyNotFound(DecodesArgument.CodingKeys.argument, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testQueryItemValueIsIncorrectType() throws {
        struct DecodesArgument: Decodable {
            var argument: Int
        }
        
        let url = try URLBuilder.buildURL(queryItems: ["argument": "Hello"])
        XCTAssertThrowsError(try decoder.decode(DecodesArgument.self, from: url)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "Unable to decode value \"Hello\" into type Int"
            )
            
            let expected = DecodingError.typeMismatch(Int.self, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    func testIndicatesKeyPresentWhenQueryItemExistsInPath() throws {
        let url = try URLBuilder.buildURL(queryItems: ["keyedInner": "Hello"])
        
        let spy = try decoder.decode(DecodingSpy.self, from: url)
        
        let observedDecoder = try XCTUnwrap(spy.observedDecoder)
        let container = try observedDecoder.container(keyedBy: DecodingSpy.CodingKeys.self)
        
        XCTAssertTrue(container.contains(.keyedInner))
    }
    
    func testIndicatesKeyNotPresentWhenQueryItemDoesNotExistInPath() throws {
        let url = try URLBuilder.buildURL()
        
        let spy = try decoder.decode(DecodingSpy.self, from: url)
        
        let observedDecoder = try XCTUnwrap(spy.observedDecoder)
        let container = try observedDecoder.container(keyedBy: DecodingSpy.CodingKeys.self)
        
        XCTAssertFalse(container.contains(.keyedInner))
    }
    
    func testPropogatesUserInfoToTopLevelDecoder() throws {
        let url = try URLBuilder.buildURL()
        
        let userInfo: [CodingUserInfoKey: String] = [CodingUserInfoKey(rawValue: "key")!: "value"]
        decoder.userInfo = userInfo
        
        let spy = try decoder.decode(DecodingSpy.self, from: url)
        
        let unwrappedUserInfo = try XCTUnwrap(spy.observedDecoder?.userInfo as? [CodingUserInfoKey: String])
        
        XCTAssertEqual(userInfo, unwrappedUserInfo)
    }
    
    func testPropogatesUserInfoToNestedKeyedDecoder() throws {
        let url = try URLBuilder.buildURL(queryItems: ["keyedInner": "Hello"])
        
        let userInfo: [CodingUserInfoKey: String] = [CodingUserInfoKey(rawValue: "key")!: "value"]
        decoder.userInfo = userInfo
        
        let spy = try decoder.decode(DecodingSpy.self, from: url)
        
        let unwrappedUserInfo = try XCTUnwrap(spy.keyedInner?.observedDecoder?.userInfo as? [CodingUserInfoKey: String])
        
        XCTAssertEqual(userInfo, unwrappedUserInfo)
    }
    
    func testTopLevelCodingPathRemainsEmpty() throws {
        let url = try URLBuilder.buildURL()
        
        let spy = try decoder.decode(DecodingSpy.self, from: url)
        
        let observedDecoder = try XCTUnwrap(spy.observedDecoder)
        
        XCTAssertTrue(observedDecoder.codingPath.isEmpty)
    }
    
    func testInnerDecoderCodingPathContainsKeyFromParent() throws {
        let url = try URLBuilder.buildURL(queryItems: ["keyedInner": "Hello"])
        
        let spy = try decoder.decode(DecodingSpy.self, from: url)
        
        let observedDecoder = try XCTUnwrap(spy.keyedInner?.observedDecoder)
        let expected = [DecodingSpy.CodingKeys.keyedInner]
        
        let areCodingPathsEqual = observedDecoder.codingPath.equals(expected)
        
        XCTAssertTrue(areCodingPathsEqual, "Expected \(expected), got \(observedDecoder.codingPath)")
    }
    
    func testDecodingEveryTypeUnderTheSun() throws {
        let allQueryItemKeysAndValues: [String: Any] = [
            "boolValue": true,
            "stringValue": "Hello",
            "doubleValue": Double(42),
            "floatValue": Float(4.2),
            "intValue": Int(1),
            "int8Value": Int8(2),
            "int16Value": Int16(3),
            "int32Value": Int32(4),
            "int64Value": Int64(5),
            "uintValue": UInt(6),
            "uint8Value": UInt8(7),
            "uint16Value": UInt16(8),
            "uint32Value": UInt32(9),
            "uint64Value": UInt64(10)
        ]
        
        let url = try URLBuilder.buildURL(queryItems: allQueryItemKeysAndValues)
        
        let decoded = try decoder.decode(EverySupportedNativeDecodableTypeUsingKeyedQueryItems.self, from: url)
        
        let expected = EverySupportedNativeDecodableTypeUsingKeyedQueryItems(
            boolValue: true,
            stringValue: "Hello",
            doubleValue: 42,
            floatValue: 4.2,
            intValue: 1,
            int8Value: 2,
            int16Value: 3,
            int32Value: 4,
            int64Value: 5,
            uintValue: 6,
            uint8Value: 7,
            uint16Value: 8,
            uint32Value: 9,
            uint64Value: 10
        )
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingEveryOptionalTypeUnderTheSun() throws {
        let url = try URLBuilder.buildURL()
        let decoded = try decoder.decode(EverySupportedOptionalNativeDecodableTypeUsingKeyedQueryItems.self, from: url)
        
        let expected = EverySupportedOptionalNativeDecodableTypeUsingKeyedQueryItems()
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingNamedBoolQueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: true)
    }
    
    func testDecodingNamedStringQueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: "Hello")
    }
    
    func testDecodingNamedDoubleQueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: Double(42))
    }
    
    func testDecodingNamedFloatQueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: Float(4.2))
    }
    
    func testDecodingNamedIntQueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: Int(1))
    }
    
    func testDecodingNamedInt8QueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: Int8(1))
    }
    
    func testDecodingNamedInt16QueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: Int16(1))
    }
    
    func testDecodingNamedInt32QueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: Int32(1))
    }
    
    func testDecodingNamedInt64QueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: Int64(1))
    }
    
    func testDecodingNamedUIntQueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: UInt(1))
    }
    
    func testDecodingNamedUInt8QueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: UInt8(1))
    }
    
    func testDecodingNamedUInt16QueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: UInt16(1))
    }
    
    func testDecodingNamedUInt32QueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: UInt32(1))
    }
    
    func testDecodingNamedUInt64QueryParameter() throws {
        try assertDecodingSingleValueQueryParameter(value: UInt64(1))
    }
    
    func testDecodingNamedCustomDecodableQueryParameter() throws {
        struct Parent: CustomStringConvertible, Decodable, Equatable {
            
            var child: Child
            var description: String { child.description }
            
            init(child: Child) {
                self.child = child
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                child = try container.decode(Child.self)
            }
            
        }
        
        struct Child: CustomStringConvertible, Decodable, Equatable {
            
            var stringValue: String
            var description: String { stringValue }
            
            init(stringValue: String) {
                self.stringValue = stringValue
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                stringValue = try container.decode(String.self)
            }
            
        }
        
        try assertDecodingSingleValueQueryParameter(value: Parent(child: Child(stringValue: "Hello")))
    }
    
    func testSingleValueContainerCodingPathRepresentsPathTakenToReachContainer() throws {
        struct Container: Decodable {
            
            enum CodingKeys: String, CodingKey {
                case leaf
            }
            
            var leaf: Leaf
            
        }
        
        struct Leaf: Decodable {
            
            var container: SingleValueDecodingContainer
            
            init(from decoder: Decoder) throws {
                self.container = try decoder.singleValueContainer()
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/path?leaf=unused"))
        let decoded = try decoder.decode(Container.self, from: url)
        let expected: [CodingKey] = [Container.CodingKeys.leaf]
        
        let containerCodingPath = decoded.leaf.container.codingPath
        
        XCTAssertTrue(
            expected.equals(containerCodingPath),
            "CodingPaths not equal - expected \(expected.map(\.stringValue)), got \(containerCodingPath.map(\.stringValue))"
        )
    }
    
    func testDecodingUsingNestedKeyedContainer() throws {
        struct Parent: Decodable, Equatable {
            
            private enum CodingKeys: String, CodingKey {
                case child
            }
            
            var child: Child
            
            init(child: Child) {
                self.child = child
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let childContainer = try container.nestedContainer(keyedBy: Child.CodingKeys.self, forKey: .child)
                let childValue = try childContainer.decode(Int.self, forKey: .value)
                child = Child(value: childValue)
            }
            
        }
        
        struct Child: Decodable, Equatable {
            
            enum CodingKeys: String, CodingKey {
                case value
            }
            
            var value: Int
            
            init(value: Int) {
                self.value = value
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/path?child=42"))
        let decoded = try decoder.decode(Parent.self, from: url)
        let expected = Parent(child: .init(value: 42))
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testDecodingUsingNestedKeyedContainer_NilValue_NonOptional() throws {
        struct Parent: Decodable, Equatable {
            
            private enum CodingKeys: String, CodingKey {
                case child
            }
            
            var child: Child
            
            init(child: Child) {
                self.child = child
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let childContainer = try container.nestedContainer(keyedBy: Child.CodingKeys.self, forKey: .child)
                let childValue = try childContainer.decode(Int.self, forKey: .value)
                child = Child(value: childValue)
            }
            
        }
        
        struct Child: Decodable, Equatable {
            
            enum CodingKeys: String, CodingKey {
                case value
            }
            
            var value: Int
            
            init(value: Int) {
                self.value = value
            }
            
        }
        
        let url = try XCTUnwrap(URL(string: "https://some.domain/path?child=%00"))
        
        XCTAssertThrowsError(try decoder.decode(Parent.self, from: url)) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "No value found for key \"value\""
            )
            
            let expected = DecodingError.valueNotFound(Int.self, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error)
        }
    }
    
    private func assertDecodingSingleValueQueryParameter<T>(
        value: T,
        line: UInt = #line
    ) throws where T: Decodable & Equatable {
        let url = try URLBuilder.buildURL(queryItems: KeyedDecodableContainer<T>.prepareQueryItem(value: value))
        let result = try decoder.decode(KeyedDecodableContainer<T>.self, from: url)
        let expected = KeyedDecodableContainer(argument: value)
        
        XCTAssertEqual(expected, result, line: line)
    }
    
}
