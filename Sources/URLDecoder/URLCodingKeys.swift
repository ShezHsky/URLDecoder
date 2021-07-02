/// A collection of `CodingKey`s exposed when decoding from `URL`s.
public enum URLCodingKeys: String, CodingKey {
    
    /// The `super` key.
    ///
    /// This key is present in a containers coding path when accessing the `superDecoder` or
    /// `superDecoder(forKey:)` on a container.
    case `super`
    
}
