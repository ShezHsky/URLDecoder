extension DecodingError.Context: Equatable {
    
    public static func == (lhs: DecodingError.Context, rhs: DecodingError.Context) -> Bool {
        let areCodingPathsEqual = lhs.codingPath.equals(rhs.codingPath)
        let areDebugDescriptionsEqual = lhs.debugDescription == rhs.debugDescription
        
        return areCodingPathsEqual && areDebugDescriptionsEqual
    }
    
}
