import Foundation.NSURL

extension URLCriteria {
    
    /// Specifies the criteria to apply to paths of inbound `URL`s.
    ///
    /// Use `Path` criteria to limit the scope of `URL`s to decode that match a path requirement, such as a particular
    /// pattern within a web service. This can be useful when a common pattern is applied across different resources
    /// that convey different meanings, but are represented using similar native types (e.g. identifiers).
    ///
    /// For example, without patch matching, the following Swift type:
    ///
    /// ```swift
    /// struct Product: Decodable {
    ///     var identifier: Int
    /// }
    /// ```
    ///
    /// Could be decoded by the following `URL`s:
    ///
    /// - `https://grocery.shopping.co.uk/product?identifier=1`
    /// - `https://grocery.shopping.co.uk/store?identifier=2`
    /// - `https://grocery.shopping.co.uk/product?identifier=3`
    ///
    /// When realistically, we'd prefer the `URLDecoder` to reject the `URL` when it does not match the `/product/`
    /// path. This can be achieved by customising the criteria of the decoder:
    ///
    /// ```swift
    /// var decoder = URLDecoder()
    /// let productsCriteria: URLCriteria.Path = .matches(.caseSensitive("/product"))
    /// decoder.urlCriteria = URLCriteria(path: productsCriteria)
    /// ```
    public enum Path: Equatable {
        
        /// Apply no critera - decode the `URL` irrespective of the contents of its path.
        case none
        
        /// Decode only `URL`s which contain the associated value as part of its path.
        case matches(Contains)
        
        
        /// Criteria that evaluates whether a `URL` contains an elementas part of its path.
        public enum Contains: Equatable {
            
            /// Requires the `URL` to contain the associated value as part of its path, using a case-sensitive
            /// comparison.
            case caseSensitive(String)
            
            /// Requires the `URL` to contain the associated value as part of its path, using a case-insensitive
            /// comparison.
            case caseInsensitive(String)
            
        }
        
    }
    
}

// MARK: - URLCriteria.Path + URLComponentsCriterion

extension URLCriteria.Path: URLComponentsCriterion {
    
    func validate(components: URLComponents) -> Bool {
        switch self {
        case .none:
            return true
            
        case .matches(let containsPathComponent):
            return containsPathComponent.validate(components: components)
        }
    }
    
}

// MARK: - URLCriteria.Path.Contains + URLComponentsCriterion

extension URLCriteria.Path.Contains: URLComponentsCriterion {
    
    func validate(components: URLComponents) -> Bool {
        switch self {
        case .caseSensitive(let subpath):
            return components.path.contains(subpath)
            
        case .caseInsensitive(let subpath):
            return components.path.localizedCaseInsensitiveContains(subpath)
        }
    }
    
}
