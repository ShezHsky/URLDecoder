import Foundation.NSURL

protocol URLComponentsCriterion {
    
    func validate(components: URLComponents) -> Bool
    
}
