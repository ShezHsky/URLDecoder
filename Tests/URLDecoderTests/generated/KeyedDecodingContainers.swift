protocol KeyedContainer: Decodable, Equatable {
    
    associatedtype ContainedValue: Decodable
    
}

struct KeyedBoolContainer: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = Bool
    
    var argument: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(Bool.self, forKey: .argument)
    }
    
}

struct KeyedStringContainer: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = String
    
    var argument: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(String.self, forKey: .argument)
    }
    
}

struct KeyedDoubleContainer: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = Double
    
    var argument: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(Double.self, forKey: .argument)
    }
    
}

struct KeyedFloatContainer: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = Float
    
    var argument: Float
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(Float.self, forKey: .argument)
    }
    
}

struct KeyedIntContainer: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = Int
    
    var argument: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(Int.self, forKey: .argument)
    }
    
}

struct KeyedInt8Container: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = Int8
    
    var argument: Int8
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(Int8.self, forKey: .argument)
    }
    
}

struct KeyedInt16Container: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = Int16
    
    var argument: Int16
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(Int16.self, forKey: .argument)
    }
    
}

struct KeyedInt32Container: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = Int32
    
    var argument: Int32
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(Int32.self, forKey: .argument)
    }
    
}

struct KeyedInt64Container: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = Int64
    
    var argument: Int64
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(Int64.self, forKey: .argument)
    }
    
}

struct KeyedUIntContainer: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = UInt
    
    var argument: UInt
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(UInt.self, forKey: .argument)
    }
    
}

struct KeyedUInt8Container: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = UInt8
    
    var argument: UInt8
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(UInt8.self, forKey: .argument)
    }
    
}

struct KeyedUInt16Container: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = UInt16
    
    var argument: UInt16
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(UInt16.self, forKey: .argument)
    }
    
}

struct KeyedUInt32Container: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = UInt32
    
    var argument: UInt32
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(UInt32.self, forKey: .argument)
    }
    
}

struct KeyedUInt64Container: KeyedContainer {

    enum CodingKeys: String, CodingKey {
        case argument
    }
    
    typealias ContainedValue = UInt64
    
    var argument: UInt64
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        argument = try container.decode(UInt64.self, forKey: .argument)
    }
    
}

