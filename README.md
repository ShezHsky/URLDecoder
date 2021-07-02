# URLDecoder

Deserialize URLs into instances of your types.

## Overview

The URLDecoder package provides a Swift `Decoder` implementation capable of deserializing a well-formed `URL` into a native Swift type. This is a convenient alternative to hand-crafting the same decoding routine using an instance of `URLComponents` directly, such as during the handling a deep link within your app.

Consider the following `GroceryProduct` Swift structure, that conforms to the `Decodable` protocol:

```swift
struct GroceryProduct: Decodable {
     var identifier: Int
     var name: String
     var points: Int
}
```

With no further code changes, the following URLs that provide key-value semantics will be decoded into the structure:

`https://grocery.shopping.co.uk/product/identifier/1/name/Durian/points/600`
`https://grocery.shopping.co.uk/product?identifier=1&name=Durian&points=600`

Alternativley, there may be situations where your existing systems do not provide key-value semantics in its URLs. For example, the following URL:

`https://grocery.shopping.co.uk/product/1/Durian/600`

Represents the same data as above, but has dropped the keys necessary to decode the structure. By customising the `init(decoder:)` function of the `GroceryProduct` to use an unkeyed container, the URL can continue to be decoded:

```swift
struct GroceryProduct: Codable {
    init(decoder: Decoder) {
        var container = try decoder.unkeyedContainer()
        let type = try container.decode(String.self)
        guard type == "product" else { throw CustomDecodingError() }
        identifier = try container.decode(Int.self)
        name = try container.decode(String.self)
        points = try container.decode(Int.self)
    }
}
```

Note that this couples the decoding implementation to the order of values in the URL, so be mindful when dipping into unkeyed territory.

Further decoding examples are available within the `Tests` folder.

## Notes

This package is a work in progress, with certain decoding pathways remaining unimplemented (as they are not exercised in apps using this package!). Feel free to submit PRs to fill them in if you find this package useful.
