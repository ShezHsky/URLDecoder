import func Foundation.NSLocalizedString

struct DecodingErrorFactory {
    
    static func makeValueNotFoundError<Key, T>(for key: Key, type: T.Type) -> DecodingError where Key: CodingKey {
        let format = NSLocalizedString(
            "ERROR_MISSING_VALUE_FORMAT",
            bundle: .module,
            comment: "Format string for the error thrown when a key is present to decode, but no value was present"
        )
        
        let debugDescription = String.localizedStringWithFormat(format, key.stringValue)
        let errorContext = DecodingError.Context(codingPath: [], debugDescription: debugDescription)
        
        return .valueNotFound(T.self, errorContext)
    }
    
    static func makeValueNotFoundError<T>(type: T.Type) -> DecodingError {
        let format = NSLocalizedString(
            "ERROR_MISSING_SINGLE_VALUE_FORMAT",
            bundle: .module,
            comment: "No value found"
        )
        
        let debugDescription = format
        let errorContext = DecodingError.Context(codingPath: [], debugDescription: debugDescription)
        
        return .valueNotFound(T.self, errorContext)
    }
    
    static func makeKeyNotFoundError<Key>(for key: Key) -> DecodingError where Key: CodingKey {
        let format = NSLocalizedString(
            "ERROR_MISSING_QUERY_ITEM_FOR_KEY_FORMAT",
            bundle: .module,
            comment: "Format string for errors thrown when no query item exists for a decoding key"
        )
        
        let debugDescription = String.localizedStringWithFormat(format, key.stringValue)
        let errorContext = DecodingError.Context(codingPath: [], debugDescription: debugDescription)
        
        return .keyNotFound(key, errorContext)
    }
    
    static func makeTypeMismatchError<T>(expected: T.Type, _ stringValue: String) -> DecodingError {
        let format = NSLocalizedString(
            "ERROR_TYPE_MISMATCH_FORMAT",
            bundle: .module,
            comment: "Format string for the error thrown when attempting to decode a type that does not align with the data in the URL"
        )
        
        let debugDescription = String.localizedStringWithFormat(format, stringValue, String(describing: expected))
        let errorContext = DecodingError.Context(codingPath: [], debugDescription: debugDescription)
        
        return .typeMismatch(expected, errorContext)
    }
    
    static func makeEndOfUnkeyedContainerError<T>(expected: T.Type) -> DecodingError {
        var message = NSLocalizedString(
            "ERROR_UNKEYED_CONTAINER_AT_END",
            bundle: .module,
            comment: "Description for that error that occurs when decoding a value at the end of an unkeyed container"
        )
        
        if T.self is UnkeyedDecodingContainer {
            message = NSLocalizedString(
                "ERROR_CANNOT_OBTAIN_NESTED_CONTAINER_AS_CONTAINER_IS_AT_END",
                bundle: .module,
                comment: "Description for that error that occurs when obtaining a nested container at the end of an unkeyed container"
            )
        }
        
        let errorContext = DecodingError.Context(
            codingPath: [],
            debugDescription: message
        )
        
        return DecodingError.valueNotFound(T.self, errorContext)
    }
    
}
