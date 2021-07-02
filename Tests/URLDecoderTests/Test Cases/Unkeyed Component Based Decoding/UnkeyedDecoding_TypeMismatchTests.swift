import URLDecoder
import XCTest

class UnkeyedDecoding_TypeMismatchTests: XCTestCase {
    
    func testDecodingSingleBoolElement_TypeMismatch() throws {
        try assert(decoding: UnkeyedBoolContainer.self, into: Bool.self)
    }
    
    func testDecodingSingleDoubleElement_TypeMismatch() throws {
        try assert(decoding: UnkeyedDoubleContainer.self, into: Double.self)
    }
    
    func testDecodingSingleFloatElement_TypeMismatch() throws {
        try assert(decoding: UnkeyedFloatContainer.self, into: Float.self)
    }
    
    func testDecodingSingleIntElement_TypeMismatch() throws {
        try assert(decoding: UnkeyedIntContainer.self, into: Int.self)
    }
    
    func testDecodingSingleInt8Element_TypeMismatch() throws {
        try assert(decoding: UnkeyedInt8Container.self, into: Int8.self)
    }
    
    func testDecodingSingleInt16Element_TypeMismatch() throws {
        try assert(decoding: UnkeyedInt16Container.self, into: Int16.self)
    }
    
    func testDecodingSingleInt32Element_TypeMismatch() throws {
        try assert(decoding: UnkeyedInt32Container.self, into: Int32.self)
    }
    
    func testDecodingSingleInt64Element_TypeMismatch() throws {
        try assert(decoding: UnkeyedInt64Container.self, into: Int64.self)
    }
    
    func testDecodingSingleUIntElement_TypeMismatch() throws {
        try assert(decoding: UnkeyedUIntContainer.self, into: UInt.self)
    }
    
    func testDecodingSingleUInt8Element_TypeMismatch() throws {
        try assert(decoding: UnkeyedUInt8Container.self, into: UInt8.self)
    }
    
    func testDecodingSingleUInt16Element_TypeMismatch() throws {
        try assert(decoding: UnkeyedUInt16Container.self, into: UInt16.self)
    }
    
    func testDecodingSingleUInt32Element_TypeMismatch() throws {
        try assert(decoding: UnkeyedUInt32Container.self, into: UInt32.self)
    }
    
    func testDecodingSingleUInt64Element_TypeMismatch() throws {
        try assert(decoding: UnkeyedUInt64Container.self, into: UInt64.self)
    }
    
    private func assert<T>(
        decoding: T.Type,
        into expectedType: Any.Type,
        line: UInt = #line
    ) throws where T: Decodable {
        let url = try XCTUnwrap(URL(string: "https://some.domain/Hello"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(T.self, from: url), line: line) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "Unable to decode value \"Hello\" into type \(String(describing: expectedType))"
            )
            
            let expected = DecodingError.typeMismatch(expectedType, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error, line: line)
        }
    }
    
}
