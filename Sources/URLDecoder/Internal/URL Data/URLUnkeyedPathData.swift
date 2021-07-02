struct URLUnkeyedPathData: URLData {
    
    var values: [String]
    
    var representitiveValue: String? {
        nil
    }
    
    var keys: [String] {
        []
    }
    
    var unkeyedValues: [String] {
        values
    }
    
    func value<Key, Value>(for key: Key, type: Value.Type) throws -> String where Key: CodingKey {
        throw NotImplemented()
    }
    
    func nestedData<Key, Value>(for key: Key, type: Value.Type) throws -> URLData where Key: CodingKey {
        throw NotImplemented()
    }
    
    func unkeyedData<Key>(for key: Key) throws -> URLData where Key: CodingKey {
        throw NotImplemented()
    }
    
}
