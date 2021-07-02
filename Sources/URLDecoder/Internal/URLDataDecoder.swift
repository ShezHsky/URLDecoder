import Foundation.NSURL

struct URLDataDecoder {
    
    var data: URLData
    var decoderCodingPath: [CodingKey]
    var decoderUserInfo: [CodingUserInfoKey: Any]
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        try T(from: self)
    }
    
}

// MARK: - URLDataDecoder + Decoder

extension URLDataDecoder: Decoder {
    
    var codingPath: [CodingKey] {
        decoderCodingPath
    }
    
    var userInfo: [CodingUserInfoKey : Any] {
        decoderUserInfo
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        let container = KeyedContainer<Key>(data: data, userInfo: userInfo, keyedCodingPath: codingPath)
        return KeyedDecodingContainer(container)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        UnkeyedContainer(data: data, userInfo: userInfo)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        SingleValueContainer(data: data, decoderCodingPath: codingPath, userInfo: userInfo)
    }
    
}
