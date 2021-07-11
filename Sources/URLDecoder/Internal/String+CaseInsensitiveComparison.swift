extension String {
    
    func caseInsensitiveEquals(_ other: String) -> Bool {
        localizedCaseInsensitiveCompare(other) == .orderedSame
    }
    
}
