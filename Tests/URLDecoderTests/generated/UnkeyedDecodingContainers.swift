struct UnkeyedBoolContainer: Decodable, Equatable {
    
    var argument: Bool
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(Bool.self)
    }
    
}

struct UnkeyedStringContainer: Decodable, Equatable {
    
    var argument: String
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(String.self)
    }
    
}

struct UnkeyedDoubleContainer: Decodable, Equatable {
    
    var argument: Double
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(Double.self)
    }
    
}

struct UnkeyedFloatContainer: Decodable, Equatable {
    
    var argument: Float
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(Float.self)
    }
    
}

struct UnkeyedIntContainer: Decodable, Equatable {
    
    var argument: Int
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(Int.self)
    }
    
}

struct UnkeyedInt8Container: Decodable, Equatable {
    
    var argument: Int8
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(Int8.self)
    }
    
}

struct UnkeyedInt16Container: Decodable, Equatable {
    
    var argument: Int16
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(Int16.self)
    }
    
}

struct UnkeyedInt32Container: Decodable, Equatable {
    
    var argument: Int32
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(Int32.self)
    }
    
}

struct UnkeyedInt64Container: Decodable, Equatable {
    
    var argument: Int64
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(Int64.self)
    }
    
}

struct UnkeyedUIntContainer: Decodable, Equatable {
    
    var argument: UInt
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(UInt.self)
    }
    
}

struct UnkeyedUInt8Container: Decodable, Equatable {
    
    var argument: UInt8
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(UInt8.self)
    }
    
}

struct UnkeyedUInt16Container: Decodable, Equatable {
    
    var argument: UInt16
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(UInt16.self)
    }
    
}

struct UnkeyedUInt32Container: Decodable, Equatable {
    
    var argument: UInt32
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(UInt32.self)
    }
    
}

struct UnkeyedUInt64Container: Decodable, Equatable {
    
    var argument: UInt64
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        argument = try container.decode(UInt64.self)
    }
    
}

