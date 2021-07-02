struct URLPathComponentData: URLData {
    
    var identifier: String
    var value: String?
    
    var representitiveValue: String? {
        value
    }
    
    var keys: [String] {
        []
    }
    
    var unkeyedValues: [String] {
        []
    }
    
    func value<Key, Value>(for key: Key, type: Value.Type) throws -> String where Key: CodingKey {
        if let value = value {
            return value
        } else {        
            throw DecodingErrorFactory.makeValueNotFoundError(for: key, type: Value.self)
        }
    }
    
    func nestedData<Key, Value>(for key: Key, type: Value.Type) throws -> URLData where Key: CodingKey {
        throw NotImplemented()
    }
    
    func unkeyedData<Key>(for key: Key) throws -> URLData where Key: CodingKey {
        throw NotImplemented()
    }
    
}
