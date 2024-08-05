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
    
    public func store<Key>(_ value: (any PreferenceValue)?, for key: Key) throws
        where Key: UserPreferenceKey, Key.RawValue == String
    {
        guard let value = value else {
            userDefaults.removeObject(forKey: key.rawValue)
            return
        }
        let data = try encoder.encode(value)
        userDefaults.setValue(data, forKey: key.rawValue)
    }

    public func get<Key, Value>(_ key: Key, for type: Value.Type) throws -> Value?
        where Value: PreferenceValue, Key: UserPreferenceKey, Key.RawValue == String
    {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        return try decoder.decode(Value.self, from: data)
    }

    public func clearValue<Key>(for key: Key)
        where Key: UserPreferenceKey, Key.RawValue == String
    {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
