import Foundation.NSURL

/// An object that decodes instances of a data type from `URL` objects.
///
/// The example below shows how to decode an instance of a simple `GroceryProduct` type from a JSON object.
/// The type adopts Codable so that it's decodable using a `URLDecoder` instance.
///
/// ```swift
/// struct GroceryProduct: Codable {
///     var identifier: Int
///     var name: String
///     var points: Int
/// }
///
/// let url = URL(string: "https://grocery.shopping.co.uk/product?identifier=1&name=Durian&points=600")!
///
/// let decoder = URLDecoder()
/// let product = try decoder.decode(GroceryProduct.self, from: url)
/// ```
///
/// You can also use URLs that tokenize data using a path, such as the following:
/// 
/// ```swift
/// let url = URL(string: "https://grocery.shopping.co.uk/product/identifier/1/name/Durian/points/600")!
/// ```
///
/// For types that require discrete processing, you can obtain the unkeyed container in order to iterate unkeyed path
/// components. For example, the following custom `init(decoder:)` implementation could be used with the associated URL:
///
/// ```swift
/// struct GroceryProduct: Codable {
///     var identifier: Int
///     var name: String
///     var points: Int
///
///     init(decoder: Decoder) {
///         var container = try decoder.unkeyedContainer()
///         let type = try container.decode(String.self)
///         guard type == "product" else { throw CustomDecodingError() }
///
///         identifier = try container.decode(Int.self)
///         name = try container.decode(String.self)
///         points = try container.decode(Int.self)
///     }
/// }
///
/// let url = URL(string: "https://grocery.shopping.co.uk/product/1/Durian/600")!
///
/// let decoder = URLDecoder()
/// let product = try decoder.decode(GroceryProduct.self, from: url)
/// ```
public struct URLDecoder {
    
    public init() {
        
    }
    
    /// A dictionary you use to customize the decoding process by providing contextual information.
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    
    /// The criteria to apply against inbound `URL`s prior to decoding.
    public var urlCriteria: URLCriteria = URLCriteria()
    
    /// Returns a value of the type you specify, decoded from a `URL` object.
    ///
    /// - Parameters:
    ///   - type: The type of the value to decode from the supplied `URL` object.
    ///   - url: The `URL` object to decode.
    ///
    /// - Throws: `URLDecodingError.malformedURL` when the components of the `URL` cannot be interpolated.
    /// - Returns: A decoded instance of the `type` to decode from the `URL`.
    public func decode<T>(_ type: T.Type, from url: URL) throws -> T where T: Decodable {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLDecodingError.malformedURL
        }
        
        guard urlCriteria.isFulfilled(by: components) else {
            throw URLDecodingError.criteriaUnsatisfied(urlCriteria, url)
        }
        
        let data = URLComponentsData(components: components)
        let decoder = URLDataDecoder(data: data, decoderCodingPath: [], decoderUserInfo: userInfo)
        return try T(from: decoder)
    }
    
}
