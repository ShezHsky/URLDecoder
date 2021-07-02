func willDecodeNil(_ stringValue: String?) -> Bool {
    stringValue == "\0"
}

func decodeBool(_ stringValue: String) throws -> Bool {
    if let boolValue = Bool(stringValue) {
        return boolValue
    } else {
        throw DecodingErrorFactory.makeTypeMismatchError(expected: Bool.self, stringValue)
    }
}

func decodeFloatingPoint<T>(_ stringValue: String) throws -> T where T: LosslessStringConvertible & BinaryFloatingPoint {
    if let floatingPointValue = T(stringValue) {
        return floatingPointValue
    } else {
        throw DecodingErrorFactory.makeTypeMismatchError(expected: T.self, stringValue)
    }
}

func decodeFixedWidthInteger<T>(_ stringValue: String) throws -> T where T: FixedWidthInteger {
    if let integerValue = T(stringValue) {
        return integerValue
    } else {
        throw DecodingErrorFactory.makeTypeMismatchError(expected: T.self, stringValue)
    }
}
