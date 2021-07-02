import Foundation.NSURL

struct URLComponentsData: URLData {
    
    var components: URLComponents
    
    var representitiveValue: String? {
        nil
    }
    
    var keys: [String] {
        let queryItems = components.queryItems ?? []
        let queryItemKeys = queryItems.map(\.name)
        let pathComponents = components.path.split(separator: "/").map(String.init)
        
        return queryItemKeys + pathComponents
    }
    
    var unkeyedValues: [String] {
        components.path.split(separator: "/").map(String.init)
    }
    
    func value<Key, Value>(for key: Key, type: Value.Type) throws -> String where Key: CodingKey {
        if let queryItem = components.queryItems?.first(where: { $0.name == key.stringValue }) {
            if let value = queryItem.value {
                return value
            } else {
                throw DecodingErrorFactory.makeValueNotFoundError(for: key, type: Value.self)
            }
        }
        
        let pathComponents = components.path.split(separator: "/")
        for (idx, component) in pathComponents.enumerated() {
            if component == key.stringValue {
                if pathComponents.count > idx + 1 {
                    let value = pathComponents[idx + 1]
                    return String(value)
                } else {
                    throw DecodingErrorFactory.makeValueNotFoundError(for: key, type: Value.self)
                }
            }
        }
        
        throw DecodingErrorFactory.makeKeyNotFoundError(for: key)
    }
    
    func nestedData<Key, Value>(for key: Key, type: Value.Type) throws -> URLData where Key: CodingKey {
        if let queryItem = components.queryItems?.first(where: { $0.name == key.stringValue }) {
            return URLQueryItemData(queryItem: queryItem)
        }
        
        let pathComponents = components.path.split(separator: "/")
        for (idx, component) in pathComponents.enumerated() where component == key.stringValue {
            return URLPathComponentData(identifier: key.stringValue, value: {
                let nextIndex = pathComponents.index(after: idx)
                if pathComponents.count > nextIndex {
                    return String(pathComponents[idx + 1])
                } else {
                    return nil
                }
            }())
        }
        
        throw DecodingErrorFactory.makeKeyNotFoundError(for: key)
    }
    
    func unkeyedData<Key>(for key: Key) throws -> URLData where Key: CodingKey {
        let pathComponents = components.path.split(separator: "/")
        for (idx, component) in pathComponents.enumerated() {
            if component == key.stringValue {
                let nextIndex = pathComponents.index(after: idx)
                let remainingValuesRange = nextIndex..<pathComponents.endIndex
                let remainingValues = pathComponents[remainingValuesRange].map(String.init)
                return URLUnkeyedPathData(values: remainingValues)
            }
        }
        
        throw DecodingErrorFactory.makeKeyNotFoundError(for: key)
    }
    
}
