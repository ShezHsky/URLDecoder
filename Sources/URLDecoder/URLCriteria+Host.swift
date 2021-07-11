import Foundation.NSURL

extension URLCriteria {
    
    /// Specifies the criteria to apply to hosts of inbound `URL`s.
    ///
    /// Use `Host` criteria to limit the scope of `URL`s to decode that match a specific host domain. This adds an
    /// additional level of verification that the decoding behaviour in apps that utilise `URL`s pulled in from external
    /// sources are in a known, trusted list.
    ///
    /// This criteria can also be utilised purely to limit a `URLDecoder` to work with `URL`s from a specific domain,
    /// which may be useful for common path patterns across domains that represent different concepts.
    public enum Host: Equatable {
        
        /// Apply no criteria - decode the `URL` irrespective of the host.
        case none
        
        /// Decode only `URL`s which match the designated host (case insensitive).
        case matches(String)
        
    }
    
}

// MARK: - URLCriteria.Host + URLComponentsCriterion

extension URLCriteria.Host: URLComponentsCriterion {
    
    func validate(components: URLComponents) -> Bool {
        switch self {
        case .none:
            return true
            
        case .matches(let host):
            guard let componentsHost = components.host else { return false }
            return host.caseInsensitiveEquals(componentsHost)
        }
    }
    
}
