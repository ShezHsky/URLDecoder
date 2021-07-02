extension URLDataDecoder {
    
    struct SingleValueContainer {
        
        var data: URLData
        var decoderCodingPath: [CodingKey]
        var userInfo: [CodingUserInfoKey: Any]
        
    }
    
}

// MARK: - URLDataDecoder.SingleValueContainer + SingleValueDecodingContainer

extension URLDataDecoder.SingleValueContainer: SingleValueDecodingContainer {
    
    var codingPath: [CodingKey] {
        decoderCodingPath
    }
    
    func decodeNil() -> Bool {
        willDecodeNil(data.representitiveValue)
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        guard let value = data.representitiveValue else {
            throw DecodingErrorFactory.makeValueNotFoundError(type: type)
        }
        
        return try decodeBool(value)
    }
    
    func decode(_ type: String.Type) throws -> String {
        guard let value = data.representitiveValue else {
            throw DecodingErrorFactory.makeValueNotFoundError(type: type)
        }
        
        return value
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        try decodeFloatingPointFromValue()
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        try decodeFloatingPointFromValue()
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try decodeFixedWidthIntegerFromValue()
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        guard let value = data.representitiveValue else {
            throw DecodingErrorFactory.makeValueNotFoundError(type: T.self)
        }
        
        let subpiece = URLDataValue(value: value)
        let decoder = URLDataDecoder(data: subpiece, decoderCodingPath: codingPath, decoderUserInfo: userInfo)
        
        return try T(from: decoder)
    }
    
    private func decodeFloatingPointFromValue<T>() throws -> T where T: LosslessStringConvertible & BinaryFloatingPoint {
        guard let stringValue = data.representitiveValue else {
            throw DecodingErrorFactory.makeValueNotFoundError(type: T.self)
        }
        
        return try decodeFloatingPoint(stringValue)
    }
    
    private func decodeFixedWidthIntegerFromValue<T>() throws -> T where T: FixedWidthInteger {
        guard let stringValue = data.representitiveValue else {
            throw DecodingErrorFactory.makeValueNotFoundError(type: T.self)
        }
        
        return try decodeFixedWidthInteger(stringValue)
    }
    
}
