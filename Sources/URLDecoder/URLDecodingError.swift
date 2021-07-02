/// An error that occurs during the decoding of a `URL`.
public enum URLDecodingError: Error {
    
    /// An indication that the `URL` could not be introspected for its values.
    case malformedURL
    
}
