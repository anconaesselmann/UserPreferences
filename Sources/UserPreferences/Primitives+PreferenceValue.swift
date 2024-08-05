//  Created by Axel Ancona Esselmann on 8/4/24.
//

import Foundation

extension Bool: PreferenceValue { }
extension String: PreferenceValue { }
extension Int: PreferenceValue { }
extension Double: PreferenceValue { }
extension UUID: PreferenceValue { }
extension URL: PreferenceValue { }
extension Int8: PreferenceValue { }
extension Int16: PreferenceValue { }
extension Int32: PreferenceValue { }
extension Int64: PreferenceValue { }
extension UInt: PreferenceValue { }
extension UInt8: PreferenceValue { }
extension UInt16: PreferenceValue { }
extension UInt32: PreferenceValue { }
extension UInt64: PreferenceValue { }

extension Set: PreferenceValue where Element == String { }

extension Set: RawRepresentable where Element == String {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Array<Element>.self, from: data)
        else {
            return nil
        }
        self = Set(result)
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(Array(self)),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
