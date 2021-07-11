import Foundation.NSURL

extension Array: URLComponentsCriterion where Element == URLComponentsCriterion {
    
    func validate(components: URLComponents) -> Bool {
        reduce(true, { $0 && $1.validate(components: components) })
    }
    
}
