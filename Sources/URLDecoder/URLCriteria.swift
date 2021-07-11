import Foundation.NSURL

/// A collection of criteria to apply against a `URL` prior to attempting to decoding into a native type.
public struct URLCriteria: Equatable {
    
    /// The criteria applied to the scheme of `URL`s to decode.
    public var scheme: Scheme
    
    /// The criteria applied to the host of `URL`s to decode.
    public var host: Host
    
    /// The criteria applied to the path of `URL`s to decode.
    public var path: Path
    
    public init(scheme: Scheme = .none, host: Host = .none, path: Path = .none) {
        self.scheme = scheme
        self.host = host
        self.path = path
    }
    
}

// MARK: - Criteria Evaluation

extension URLCriteria {
    
    func isFulfilled(by components: URLComponents) -> Bool {
        [scheme, host, path].validate(components: components)
    }
    
}
