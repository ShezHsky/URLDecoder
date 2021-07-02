struct TypeMismatchError: Error {
    
    var expected: Any.Type
    var value: String
    
}
