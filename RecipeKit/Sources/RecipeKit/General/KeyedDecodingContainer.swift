import Foundation

// MARK: Decoding Arrays

extension KeyedDecodingContainer {
    
    /// Used for skipping elements that fail to be decoded.
    private struct EmptyDecodable: Decodable {}
    
    /// Safely decode an array of decodable items. Elements that fail to be decoded will be skipped.
    public func decodeArray<T: Decodable>(of type: T.Type, forKey key: K) -> [T] {
        guard var container = try? nestedUnkeyedContainer(forKey: key) else {
            return []
        }
        var elements = [T]()
        
        if let capacity = container.count {
            elements.reserveCapacity(capacity)
        }
        
        while !container.isAtEnd {
            do {
                let value = try container.decode(T.self)
                elements.append(value)
            } catch {
                // FIXME: Log the error to SentrySDK
                
                switch error {
                case DecodingError.typeMismatch(let type, let context):
                    assertionFailure("Type mismatch: \(type) \(context)")
                case DecodingError.valueNotFound(let type, let context):
                    assertionFailure("Value not found: \(type) \(context)")
                case DecodingError.keyNotFound(let key, let context):
                    assertionFailure("Key not found: \(key) \(context)")
                case DecodingError.dataCorrupted(let context):
                    assertionFailure("Data corrupted: \(context)")
                default:
                    assertionFailure("Error: \(error.localizedDescription)")
                }
                
                // The container does not proceed to the next element upon
                // failure so `EmptyDecodable` is needed to proceed.
                // See the Swift ticket: https://bugs.swift.org/browse/SR-5953.
                _ = try? container.decode(EmptyDecodable.self)
            }
        }
        
        return elements
    }
}
