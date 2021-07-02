struct EverySupportedOptionalNativeDecodableTypeUsingUnkeyedContainerDecoding: Decodable, Equatable {
    
    var boolValue: Bool?
    var stringValue: String?
    var doubleValue: Double?
    var floatValue: Float?
    var intValue: Int?
    var int8Value: Int8?
    var int16Value: Int16?
    var int32Value: Int32?
    var int64Value: Int64?
    var uintValue: UInt?
    var uint8Value: UInt8?
    var uint16Value: UInt16?
    var uint32Value: UInt32?
    var uint64Value: UInt64?
    
    init(
        boolValue: Bool? = nil,
        stringValue: String? = nil,
        doubleValue: Double? = nil,
        floatValue: Float? = nil,
        intValue: Int? = nil,
        int8Value: Int8? = nil,
        int16Value: Int16? = nil,
        int32Value: Int32? = nil,
        int64Value: Int64? = nil,
        uintValue: UInt? = nil,
        uint8Value: UInt8? = nil,
        uint16Value: UInt16? = nil,
        uint32Value: UInt32? = nil,
        uint64Value: UInt64? = nil
    ) {
        self.boolValue = boolValue
        self.stringValue = stringValue
        self.doubleValue = doubleValue
        self.floatValue = floatValue
        self.intValue = intValue
        self.int8Value = int8Value
        self.int16Value = int16Value
        self.int32Value = int32Value
        self.int64Value = int64Value
        self.uintValue = uintValue
        self.uint8Value = uint8Value
        self.uint16Value = uint16Value
        self.uint32Value = uint32Value
        self.uint64Value = uint64Value
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        boolValue = try container.decodeIfPresent(Bool.self)
        stringValue = try container.decodeIfPresent(String.self)
        doubleValue = try container.decodeIfPresent(Double.self)
        floatValue = try container.decodeIfPresent(Float.self)
        intValue = try container.decodeIfPresent(Int.self)
        int8Value = try container.decodeIfPresent(Int8.self)
        int16Value = try container.decodeIfPresent(Int16.self)
        int32Value = try container.decodeIfPresent(Int32.self)
        int64Value = try container.decodeIfPresent(Int64.self)
        uintValue = try container.decodeIfPresent(UInt.self)
        uint8Value = try container.decodeIfPresent(UInt8.self)
        uint16Value = try container.decodeIfPresent(UInt16.self)
        uint32Value = try container.decodeIfPresent(UInt32.self)
        uint64Value = try container.decodeIfPresent(UInt64.self)
    }
    
}
