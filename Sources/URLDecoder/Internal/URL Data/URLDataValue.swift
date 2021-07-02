struct URLDataValue: URLData {
    
    var value: String
    
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
        value
    }
    
    func nestedData<Key, Value>(for key: Key, type: Value.Type) throws -> URLData where Key: CodingKey {
        throw NotImplemented()
    }
    
    func unkeyedData<Key>(for key: Key) throws -> URLData where Key: CodingKey {
        throw NotImplemented()
    }
    
}
