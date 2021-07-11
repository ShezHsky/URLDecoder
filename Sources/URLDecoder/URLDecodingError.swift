import Foundation.NSURL

/// An error that occurs during the decoding of a `URL`.
public enum URLDecodingError: Error {
    
    /// An indication that the `URL` could not be introspected for its values.
    case malformedURL
    
    /// An indication that the `urlCriteria` of the `URLDecoder` was not satisfied by the `URL` being decoded.
    ///
    /// This error is thrown when the `URLDecoder`'s `urlCriteria` has not been satisfied by the inbound `URL` to
    /// decode. The associated values of this error specify both the criteria and the `URL` that caused this error to
    /// occur.
    case criteriaUnsatisfied(URLCriteria, URL)
    
}

// MARK: - URLDecodingError + Equatable

extension URLDecodingError: Equatable { }
