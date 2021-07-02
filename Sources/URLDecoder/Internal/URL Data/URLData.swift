protocol URLData {
    
    var representitiveValue: String? { get }
    var keys: [String] { get }
    var unkeyedValues: [String] { get }
    
    func value<Key, Value>(for key: Key, type: Value.Type) throws -> String where Key: CodingKey
    func nestedData<Key, Value>(for key: Key, type: Value.Type) throws -> URLData where Key: CodingKey
    func unkeyedData<Key>(for key: Key) throws -> URLData where Key: CodingKey
    
}
