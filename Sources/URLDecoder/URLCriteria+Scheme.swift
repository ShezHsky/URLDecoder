import Foundation.NSURL

extension URLCriteria {
    
    /// Specifies the criteria to apply to schemes of inbound `URL`s.
    ///
    /// Use `Scheme` criteria to limit the scope of `URL`s to decode to a specific scheme, e.g. https.
    public enum Scheme: Equatable {
        
        /// Apply no criteria - decode the `URL` irrespective of the scheme.
        case none
        
        /// Decode only `URL`s which match the designated scheme (case insensitive).
        case matches(String)
        
    }
    
}

// MARK: - URLCriteria.Scheme + URLComponentsCriterion

extension URLCriteria.Scheme: URLComponentsCriterion {
    
    func validate(components: URLComponents) -> Bool {
        switch self {
        case .none:
            return true
            
        case .matches(let scheme):
            guard let componentsScheme = components.scheme else { return false }
            return scheme.caseInsensitiveEquals(componentsScheme)
        }
    }
    
}
