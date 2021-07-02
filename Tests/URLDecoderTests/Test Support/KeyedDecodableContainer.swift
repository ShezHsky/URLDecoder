struct KeyedDecodableContainer<T>: Decodable, Equatable where T: Decodable & Equatable {
    
    var argument: T
    
    static func prepareQueryItem(value: T) -> [String: String] {
        ["argument": String(describing: value)]
    }
    
}
