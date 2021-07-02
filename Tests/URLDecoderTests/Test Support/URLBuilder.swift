import Foundation.NSURL
import XCTest

struct URLBuilder {
    
    static func buildURL(queryItems: [String: Any] = [:]) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "some.domain"
        components.path = "/path"
        
        components.queryItems = queryItems.map { (key, value) in
            URLQueryItem(name: key, value: String(describing: value))
        }
        
        return try XCTUnwrap(components.url)
    }
    
}
