struct DecodingSpy: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case keyedInner
    }
    
    var observedDecoder: Decoder?
    var keyedInner: KeyedInner?
    
    init(from decoder: Decoder) throws {
        observedDecoder = decoder
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        keyedInner = try container.decodeIfPresent(KeyedInner.self, forKey: .keyedInner)
    }
    
    struct KeyedInner: Decodable {
        
        var observedDecoder: Decoder?
        var value: String
        
        init(from decoder: Decoder) throws {
            observedDecoder = decoder
            
            let container = try decoder.singleValueContainer()
            value = try container.decode(String.self)
        }
        
    }
    
}
