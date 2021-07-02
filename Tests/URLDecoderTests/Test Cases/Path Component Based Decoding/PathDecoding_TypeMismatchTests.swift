import URLDecoder
import XCTest

class PathDecoding_TypeMismatchTests: XCTestCase {

    func testDecodingNamedBoolQueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: Bool.self, value: "Hello")
    }
    
    func testDecodingNamedDoubleQueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: Double.self, value: "Hello")
    }
    
    func testDecodingNamedFloatQueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: Float.self, value: "Hello")
    }
    
    func testDecodingNamedIntQueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: Int.self, value: "Hello")
    }
    
    func testDecodingNamedInt8QueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: Int8.self, value: "Hello")
    }
    
    func testDecodingNamedInt16QueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: Int16.self, value: "Hello")
    }
    
    func testDecodingNamedInt32QueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: Int32.self, value: "Hello")
    }
    
    func testDecodingNamedInt64QueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: Int64.self, value: "Hello")
    }
    
    func testDecodingNamedUIntQueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: UInt.self, value: "Hello")
    }
    
    func testDecodingNamedUInt8QueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: UInt8.self, value: "Hello")
    }
    
    func testDecodingNamedUInt16QueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: UInt16.self, value: "Hello")
    }
    
    func testDecodingNamedUInt32QueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: UInt32.self, value: "Hello")
    }
    
    func testDecodingNamedUInt64QueryParameter_TypeMismatch() throws {
        try assertDecodingMismatchedTypeForSinglePathComponentValue(attempted: UInt64.self, value: "Hello")
    }
    
    private func assertDecodingMismatchedTypeForSinglePathComponentValue<Attempted, Unexpected>(
        attempted: Attempted.Type,
        value: Unexpected,
        line: UInt = #line
    ) throws where Attempted: Decodable & Equatable, Unexpected: Decodable & Equatable {
        let decoder = URLDecoder()
        let url = try XCTUnwrap(URL(string: "https://some.domain/argument/Hello"))
        
        XCTAssertThrowsError(try decoder.decode(KeyedDecodableContainer<Attempted>.self, from: url), line: line) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "Unable to decode value \"\(String(describing: value))\" into type \(String(describing: Attempted.self))"
            )
            
            let expected = DecodingError.typeMismatch(Attempted.self, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error, line: line)
        }
    }
    
}
