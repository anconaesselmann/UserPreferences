//  Created by Axel Ancona Esselmann on 11/17/23.
//

import Foundation

@MainActor
public struct UserDefaultsPreferencesStore: PreferencesStoreProtocol {

    public static let shared = UserDefaultsPreferencesStore()

    private let userDefaults = UserDefaults.standard

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() { }

    public func store(_ value: (any PreferenceValue)?, for key: any PreferenceKey) throws {
        guard let value = value else {
            userDefaults.removeObject(forKey: key.rawValue)
            return
        }
        let data = try encoder.encode(value)
        userDefaults.setValue(data, forKey: key.rawValue)
    }

    public func get<Value>(_ key: any PreferenceKey, for type: Value.Type) throws -> Value?
        where Value: PreferenceValue
    {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        return try decoder.decode(Value.self, from: data)
    }

    public func clearValue(for key: any PreferenceKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
