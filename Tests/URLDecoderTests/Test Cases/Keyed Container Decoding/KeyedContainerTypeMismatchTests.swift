import URLDecoder
import XCTest

class KeyedContainerTypeMismatchTests: XCTestCase {
    
    func testDecodingBoolWithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedBoolContainer.self)
    }
    
    func testDecodingDoubleWithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedDoubleContainer.self)
    }
    
    func testDecodingFloatWithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedFloatContainer.self)
    }
    
    func testDecodingIntWithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedIntContainer.self)
    }
    
    func testDecodingInt8WithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedInt8Container.self)
    }
    
    func testDecodingInt16WithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedInt16Container.self)
    }
    
    func testDecodingInt32WithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedInt32Container.self)
    }
    
    func testDecodingInt64WithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedInt64Container.self)
    }
    
    func testDecodingUIntWithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedUIntContainer.self)
    }
    
    func testDecodingUInt8WithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedUInt8Container.self)
    }
    
    func testDecodingUInt16WithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedUInt16Container.self)
    }
    
    func testDecodingUInt32WithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedUInt32Container.self)
    }
    
    func testDecodingUInt64WithTypeMismatch() throws {
        try assertTypeMismatch(decoding: KeyedUInt64Container.self)
    }
    
    private func assertTypeMismatch<Container>(
        decoding: Container.Type,
        line: UInt = #line
    ) throws where Container: KeyedContainer {
        let url = try XCTUnwrap(URL(string: "https://some.domain/argument/Hello"))
        let decoder = URLDecoder()
        
        XCTAssertThrowsError(try decoder.decode(Container.self, from: url), line: line) { (error) in
            let expectedContext = DecodingError.Context(
                codingPath: [],
                debugDescription: "Unable to decode value \"Hello\" into type \(String(describing: Container.ContainedValue.self))"
            )
            
            let expected = DecodingError.typeMismatch(Container.ContainedValue.self, expectedContext)
            
            assertExpectedDecodingError(expected, equals: error, line: line)
        }
    }
    
}
