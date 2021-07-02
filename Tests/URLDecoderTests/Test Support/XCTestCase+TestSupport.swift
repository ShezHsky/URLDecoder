import XCTest

extension XCTestCase {
    
    func assertExpectedDecodingError(
        _ expected: DecodingError,
        equals actual: Error,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard let actual = actual as? DecodingError else {
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
        
        if expected != actual {
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
