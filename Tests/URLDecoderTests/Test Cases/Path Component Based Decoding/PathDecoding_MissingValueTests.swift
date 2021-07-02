import XCTest
import URLDecoder

class PathDecoding_MissingValueTests: XCTestCase {
    
    func testDecodingNamedBoolQueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: Bool.self)
    }
    
    func testDecodingNamedStringQueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: String.self)
    }
    
    func testDecodingNamedDoubleQueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: Double.self)
    }
    
    func testDecodingNamedFloatQueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: Float.self)
    }
    
    func testDecodingNamedIntQueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: Int.self)
    }
    
    func testDecodingNamedInt8QueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: Int8.self)
    }
    
    func testDecodingNamedInt16QueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: Int16.self)
    }
    
    func testDecodingNamedInt32QueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: Int32.self)
    }
    
    func testDecodingNamedInt64QueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: Int64.self)
    }
    
    func testDecodingNamedUIntQueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: UInt.self)
    }
    
    func testDecodingNamedUInt8QueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: UInt8.self)
    }
    
    func testDecodingNamedUInt16QueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: UInt16.self)
    }
    
    func testDecodingNamedUInt32QueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: UInt32.self)
    }
    
    func testDecodingNamedUInt64QueryParameter_ValueMissing() throws {
        try assertDecodingMissingTypeForSinglePathComponentValue(attempted: UInt64.self)
    }
    
    func testDecodingNamedCustonQueryParameter_ValueMissing() throws {
        struct Container: Decodable, Equatable {
            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                _ = try container.decode(CanBeDecoded.self)
            }
            
            struct CanBeDecoded: Decodable, Equatable {
                var value: String
            }
        }
        
        try assertDecodingMissingTypeForSinglePathComponentValue(
            attempted: Container.self,
            expected: Container.CanBeDecoded.self
        )
    }
    
    private func assertDecodingMissingTypeForSinglePathComponentValue<Attempted>(
        attempted: Attempted.Type,
        expected: Any.Type = Attempted.self,
        line: UInt = #line
    ) throws where Attempted: Decodable & Equatable {
        let decoder = URLDecoder()
        let url = try XCTUnwrap(URL(string: "https://some.domain/argument"))
        
        XCTAssertThrowsError(try decoder.decode(KeyedDecodableContainer<Attempted>.self, from: url), line: line) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "No value found"
            )
            
            let expected = DecodingError.valueNotFound(expected, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error, line: line)
        }
    }
    
}
