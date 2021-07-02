extension CodingKey {
    
    func equals(_ other: CodingKey) -> Bool {
        stringValue == other.stringValue && intValue == other.intValue
    }
    
}

extension Array where Element == CodingKey {
    
    func equals(_ other: [Element]) -> Bool {
        elementsEqual(other, by: { $0.equals($1) })
    }
    
}
