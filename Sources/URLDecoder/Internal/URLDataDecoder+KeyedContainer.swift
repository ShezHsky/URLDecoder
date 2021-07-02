import func Foundation.NSLocalizedString

extension URLDataDecoder {
    
    struct KeyedContainer<Key> where Key: CodingKey {
        
        var data: URLData
        var userInfo: [CodingUserInfoKey: Any]
        var keyedCodingPath: [CodingKey]
        
    }
    
}

// MARK: - URLDataDecoder.KeyedContainer + KeyedDecodingContainerProtocol

extension URLDataDecoder.KeyedContainer: KeyedDecodingContainerProtocol {
    
    var codingPath: [CodingKey] {
        keyedCodingPath
    }
    
    var allKeys: [Key] {
        data.keys.compactMap(Key.init(stringValue:))
    }
    
    func contains(_ key: Key) -> Bool {
        allKeys.contains { (presentKey) in
            presentKey.stringValue == key.stringValue
        }
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        let value = try data.value(for: key, type: Any.self)
        return willDecodeNil(value)
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        let stringValue = try data.value(for: key, type: Bool.self)
        guard let value = Bool(stringValue) else {
            throw DecodingErrorFactory.makeTypeMismatchError(expected: Bool.self, stringValue)
        }
        
        return value
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try attemptDecode(key: key, { $0 })
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        try attemptDecode(key: key, decodeFloatingPoint)
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try attemptDecode(key: key, decodeFloatingPoint)
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        try attemptDecode(key: key, decodeFixedWidthInteger)
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let subpiece = try data.nestedData(for: key, type: KeyedDecodingContainer<NestedKey>.self)
        let decoder = URLDataDecoder(data: subpiece, decoderCodingPath: [], decoderUserInfo: [:])
        let container = try decoder.container(keyedBy: type)
        
        return container
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        let subpiece = try data.unkeyedData(for: key)
        let decoder = URLDataDecoder(data: subpiece, decoderCodingPath: [], decoderUserInfo: [:])
        let container = try decoder.unkeyedContainer()
        
        return container
    }
    
    func superDecoder() throws -> Decoder {
        decoder(for: URLCodingKeys.super)
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        decoder(for: key)
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        let path = codingPath + [key]
        let subpiece = try data.nestedData(for: key, type: T.self)
        let decoder = URLDataDecoder(data: subpiece, decoderCodingPath: path, decoderUserInfo: userInfo)
        
        return try decoder.decode(type)
    }
    
    private func attemptDecode<T>(key: Key, _ closure: (String) throws -> T) throws -> T where T: Decodable {
        let value = try data.value(for: key, type: T.self)
        let decodedValue = try closure(value)
        
        return decodedValue
    }
    
    private func decoder<Key>(for key: Key) -> Decoder where Key: CodingKey {
        URLDataDecoder(data: data, decoderCodingPath: codingPath + [key], decoderUserInfo: userInfo)
    }
    
}
