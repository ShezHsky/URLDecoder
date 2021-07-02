import Foundation.NSURL

struct URLQueryItemData: URLData {
    
    var queryItem: URLQueryItem
    
    var representitiveValue: String? {
        queryItem.value
    }
    
    var keys: [String] {
        []
    }
    
    var unkeyedValues: [String] {
        []
    }
    
    func value<Key, Value>(for key: Key, type: Value.Type) throws -> String where Key: CodingKey {
        guard let value = queryItem.value, willDecodeNil(value) == false else {
            throw DecodingErrorFactory.makeValueNotFoundError(for: key, type: type)
        }
        
        return value
    }
    
    func nestedData<Key, Value>(for key: Key, type: Value.Type) throws -> URLData where Key: CodingKey {
        throw NotImplemented()
    }
    
    func unkeyedData<Key>(for key: Key) throws -> URLData where Key: CodingKey {
        throw NotImplemented()
    }
    
}
