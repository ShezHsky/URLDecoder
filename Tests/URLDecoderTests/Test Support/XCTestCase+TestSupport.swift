import URLDecoder
import XCTest

extension XCTestCase {
    
    func assertExpectedDecodingError<ErrorType>(
        _ expected: ErrorType,
        equals actual: Error,
        file: StaticString = #filePath,
        line: UInt = #line
    ) where ErrorType: Error & Equatable {
        guard let actualError = actual as? ErrorType else {
            let issue = XCTIssue(
                type: .assertionFailure,
                compactDescription: "Expected a \(ErrorType.self), got \(type(of: actual))",
                sourceCodeContext: XCTSourceCodeContext(
                    location: XCTSourceCodeLocation(filePath: file, lineNumber: line)
                )
            )
            
            record(issue)
            return
        }
        
        if actualError != expected {
            let issue = XCTIssue(
                type: .assertionFailure,
                compactDescription: "Errors are not equal - expected \(expected), received \(actual)",
                sourceCodeContext: XCTSourceCodeContext(
                    location: XCTSourceCodeLocation(filePath: file, lineNumber: line)
                )
            )
            
            record(issue)
        }
    }
    
}
