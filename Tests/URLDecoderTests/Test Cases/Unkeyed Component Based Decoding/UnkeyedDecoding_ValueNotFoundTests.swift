import XCTest
import URLDecoder

class UnkeyedDecoding_ValueNotFoundTests: XCTestCase {
    
    func testBoolValueNotFound() throws {
        try assert(decoding: UnkeyedBoolContainer.self, intoMissing: Bool.self)
    }
    
    func testStringValueNotFound() throws {
        try assert(decoding: UnkeyedStringContainer.self, intoMissing: String.self)
    }
    
    func testDoubleValueNotFound() throws {
        try assert(decoding: UnkeyedDoubleContainer.self, intoMissing: Double.self)
    }
    
    func testFloatValueNotFound() throws {
        try assert(decoding: UnkeyedFloatContainer.self, intoMissing: Float.self)
    }
    
    func testIntValueNotFound() throws {
        try assert(decoding: UnkeyedIntContainer.self, intoMissing: Int.self)
    }
    
    func testInt8ValueNotFound() throws {
        try assert(decoding: UnkeyedInt8Container.self, intoMissing: Int8.self)
    }
    
    func testInt16ValueNotFound() throws {
        try assert(decoding: UnkeyedInt16Container.self, intoMissing: Int16.self)
    }
    
    func testInt32ValueNotFound() throws {
        try assert(decoding: UnkeyedInt32Container.self, intoMissing: Int32.self)
    }
    
    func testInt64ValueNotFound() throws {
        try assert(decoding: UnkeyedInt64Container.self, intoMissing: Int64.self)
    }
    
    func testUIntValueNotFound() throws {
        try assert(decoding: UnkeyedUIntContainer.self, intoMissing: UInt.self)
    }
    
    func testUInt8ValueNotFound() throws {
        try assert(decoding: UnkeyedUInt8Container.self, intoMissing: UInt8.self)
    }
    
    func testUInt16ValueNotFound() throws {
        try assert(decoding: UnkeyedUInt16Container.self, intoMissing: UInt16.self)
    }
    
    func testUInt32ValueNotFound() throws {
        try assert(decoding: UnkeyedUInt32Container.self, intoMissing: UInt32.self)
    }
    
    func testUInt64ValueNotFound() throws {
        try assert(decoding: UnkeyedUInt64Container.self, intoMissing: UInt64.self)
    }
    
    private func assert<T>(
        decoding: T.Type,
        intoMissing expectedType: Any.Type,
        line: UInt = #line
    ) throws where T: Decodable {
        let url = try XCTUnwrap(URL(string: "https://some.domain"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(T.self, from: url), line: line) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "Unkeyed container is at end."
            )
            
            let expected = DecodingError.valueNotFound(expectedType, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error, line: line)
        }
    }
    
}
