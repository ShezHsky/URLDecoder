extension URLDataDecoder {
    
    struct UnkeyedContainer {
        
        private let userInfo: [CodingUserInfoKey: Any]
        private var unkeyedValues: [String]
        private var numberOfValues: Int
        private var currentValueIndex = 0
        
        init(data: URLData, userInfo: [CodingUserInfoKey: Any]) {
            self.userInfo = userInfo
            
            self.unkeyedValues = data.unkeyedValues
            self.numberOfValues = unkeyedValues.count
        }
        
    }
    
}

// MARK: - Data Access

extension URLDataDecoder.UnkeyedContainer {
    
    private var currentValue: String {
        unkeyedValues[currentValueIndex]
    }
    
    private mutating func nextValue<T>(for type: T.Type) throws -> String {
        guard !isAtEnd else {
            throw DecodingErrorFactory.makeEndOfUnkeyedContainerError(expected: T.self)
        }
        
        let value = currentValue
        currentValueIndex += 1
        
        return value
    }
    
}

// MARK: - URLDataDecoder.UnkeyedContainer + UnkeyedDecodingContainer

extension URLDataDecoder.UnkeyedContainer: UnkeyedDecodingContainer {
    
    var codingPath: [CodingKey] {
        []
    }
    
    var count: Int? {
        numberOfValues
    }
    
    var isAtEnd: Bool {
        currentValueIndex == numberOfValues
    }
    
    var currentIndex: Int {
        currentValueIndex
    }
    
    mutating func decodeNil() throws -> Bool {
        if willDecodeNil(currentValue) {
            currentValueIndex += 1
            return true
        }
        
        return false
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        try decodeBool(try nextValue(for: Bool.self))
    }
    
    mutating func decode(_ type: String.Type) throws -> String {
        try nextValue(for: String.self)
    }
    
    mutating func decode(_ type: Double.Type) throws -> Double {
        try decodeFloatingPoint(try nextValue(for: Double.self))
    }
    
    mutating func decode(_ type: Float.Type) throws -> Float {
        try decodeFloatingPoint(try nextValue(for: Float.self))
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        try decodeFixedWidthInteger(try nextValue(for: Int.self))
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        try decodeFixedWidthInteger(try nextValue(for: Int8.self))
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        try decodeFixedWidthInteger(try nextValue(for: Int16.self))
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        try decodeFixedWidthInteger(try nextValue(for: Int32.self))
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        try decodeFixedWidthInteger(try nextValue(for: Int64.self))
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        try decodeFixedWidthInteger(try nextValue(for: UInt.self))
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        try decodeFixedWidthInteger(try nextValue(for: UInt8.self))
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        try decodeFixedWidthInteger(try nextValue(for: UInt16.self))
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        try decodeFixedWidthInteger(try nextValue(for: UInt32.self))
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        try decodeFixedWidthInteger(try nextValue(for: UInt64.self))
    }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        let subpiece = URLDataValue(value: try nextValue(for: T.self))
        let decoder = URLDataDecoder(data: subpiece, decoderCodingPath: [], decoderUserInfo: userInfo)
        
        return try T(from: decoder)
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        throw NotCurrentlySupported()
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw NotCurrentlySupported()
    }
    
    mutating func superDecoder() throws -> Decoder {
        throw NotCurrentlySupported()
    }
    
    private struct NotCurrentlySupported: Error { }
    
}
