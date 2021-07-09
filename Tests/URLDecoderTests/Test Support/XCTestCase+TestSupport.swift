import XCTest

extension XCTestCase {
    
    func assertExpectedDecodingError(
        _ expected: DecodingError,
        equals actual: Error,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard let actualError = actual as? DecodingError else {
            let issue = XCTIssue(
                type: .assertionFailure,
                compactDescription: "Expected a \(DecodingError.self), got \(type(of: actual))",
                sourceCodeContext: XCTSourceCodeContext(
                    location: XCTSourceCodeLocation(filePath: file, lineNumber: line)
                )
            )
            
            record(issue)
            return
        }
        
        if expected != actualError {
            let issue = XCTIssue(
                type: .assertionFailure,
                compactDescription: "Errors are not equal - expected \(expected), received \(actualError)",
                sourceCodeContext: XCTSourceCodeContext(
                    location: XCTSourceCodeLocation(filePath: file, lineNumber: line)
                )
            )
            
            record(issue)
        }
    }
    
}
