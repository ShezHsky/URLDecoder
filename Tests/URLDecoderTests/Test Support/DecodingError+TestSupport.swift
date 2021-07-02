extension DecodingError: Equatable {
    
    public static func == (lhs: DecodingError, rhs: DecodingError) -> Bool {
        switch (lhs, rhs) {
        case (.typeMismatch(let lhsType, let lhsContext), .typeMismatch(let rhsType, let rhsContext)):
            return lhsType == rhsType && lhsContext == rhsContext
            
        case (.keyNotFound(let lhsKey, let lhsContext), .keyNotFound(let rhsKey, let rhsContext)):
            return lhsKey.equals(rhsKey) && lhsContext == rhsContext
            
        case (.valueNotFound(let lhsType, let lhsContext), .valueNotFound(let rhsType, let rhsContext)):
            return lhsType == rhsType && lhsContext == rhsContext
            
        case (.dataCorrupted(let lhsContext), .dataCorrupted(let rhsContext)):
            return lhsContext == rhsContext
            
        default:
            return false
        }
    }
    
}
