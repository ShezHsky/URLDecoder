struct EverySupportedNativeDecodableTypeUsingUnkeyedContainerDecoding: Decodable, Equatable {
    
    var boolValue: Bool
    var stringValue: String
    var doubleValue: Double
    var floatValue: Float
    var intValue: Int
    var int8Value: Int8
    var int16Value: Int16
    var int32Value: Int32
    var int64Value: Int64
    var uintValue: UInt
    var uint8Value: UInt8
    var uint16Value: UInt16
    var uint32Value: UInt32
    var uint64Value: UInt64
    
    init(
        boolValue: Bool,
        stringValue: String,
        doubleValue: Double,
        floatValue: Float,
        intValue: Int,
        int8Value: Int8,
        int16Value: Int16,
        int32Value: Int32,
        int64Value: Int64,
        uintValue: UInt,
        uint8Value: UInt8,
        uint16Value: UInt16,
        uint32Value: UInt32,
        uint64Value: UInt64
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
        boolValue = try container.decode(Bool.self)
        stringValue = try container.decode(String.self)
        doubleValue = try container.decode(Double.self)
        floatValue = try container.decode(Float.self)
        intValue = try container.decode(Int.self)
        int8Value = try container.decode(Int8.self)
        int16Value = try container.decode(Int16.self)
        int32Value = try container.decode(Int32.self)
        int64Value = try container.decode(Int64.self)
        uintValue = try container.decode(UInt.self)
        uint8Value = try container.decode(UInt8.self)
        uint16Value = try container.decode(UInt16.self)
        uint32Value = try container.decode(UInt32.self)
        uint64Value = try container.decode(UInt64.self)
    }
    
}
