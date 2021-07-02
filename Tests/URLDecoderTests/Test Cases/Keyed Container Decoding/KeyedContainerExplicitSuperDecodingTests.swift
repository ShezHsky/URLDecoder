import URLDecoder
import XCTest

class KeyedContainerExplicitSuperDecodingTests: XCTestCase {
    
    func testDecodingSuper() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/path?childValue=10&superValue=100"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(Child.self, from: url)
        let expected = Child(childValue: 10, superValue: 100)
        
        XCTAssertEqual(expected, decoded)
    }
    
    func testSuperDecoderInheritsUserInfo() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/path?childValue=10&superValue=100"))
        
        let userInfo: [CodingUserInfoKey: String] = [CodingUserInfoKey(rawValue: "key")!: "value"]
        var decoder = URLDecoder()
        decoder.userInfo = userInfo
        
        let decoded = try decoder.decode(Child.self, from: url)
        let unwrappedUserInfo = try XCTUnwrap(decoded.superDecoder?.userInfo as? [CodingUserInfoKey: String])
        
        XCTAssertEqual(userInfo, unwrappedUserInfo)
    }
    
    func testSuperDecoderInheritsCodingPath() throws {
        let url = try XCTUnwrap(URL(string: "https://some.domain/path?childValue=10&superValue=100"))
        let decoder = URLDecoder()
        let decoded = try decoder.decode(Child.self, from: url)
        let codingPath = try XCTUnwrap(decoded.superDecoder?.codingPath as? [Child.CodingKeys])
        let expected = [Child.CodingKeys.unusedExceptForProvidingSuperWithDecoder]
        
        XCTAssertEqual(expected, codingPath)
    }
    
    private class Super: Decodable {
        private enum CodingKeys: String, CodingKey {
            case superValue
        }
        
        var superValue: Int
        var superDecoder: Decoder?
        
        init(superValue: Int) {
            self.superValue = superValue
        }
        
        required init(from decoder: Decoder) throws {
            self.superDecoder = decoder
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            superValue = try container.decode(Int.self, forKey: .superValue)
        }
    }
    
    private class Child: Super, Equatable {
        static func == (lhs: Child, rhs: Child) -> Bool {
            lhs.superValue == rhs.superValue && lhs.childValue == rhs.childValue
        }
        
        enum CodingKeys: String, CodingKey {
            case childValue
            case unusedExceptForProvidingSuperWithDecoder
        }
        
        var childValue: Int
        
        init(childValue: Int, superValue: Int) {
            self.childValue = childValue
            super.init(superValue: superValue)
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            childValue = try container.decode(Int.self, forKey: .childValue)
            
            let superDecoder = try container.superDecoder(forKey: .unusedExceptForProvidingSuperWithDecoder)
            try super.init(from: superDecoder)
        }
    }
    
}
