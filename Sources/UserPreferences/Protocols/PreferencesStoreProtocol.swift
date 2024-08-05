//  Created by Axel Ancona Esselmann on 11/20/23.
//

import Foundation

public protocol PreferencesStoreProtocol {
    @MainActor
    func store<Key>(_ value: (any PreferenceValue)?, for key: Key) throws
        where Key: UserPreferenceKey, Key.RawValue == String

    @MainActor
    func get<Key, Value>(_ key: Key, for type: Value.Type) throws -> Value?
        where Value: PreferenceValue, Key: UserPreferenceKey, Key.RawValue == String

    @MainActor
    func clearValue<Key>(for key: Key)
        where Key: UserPreferenceKey, Key.RawValue == String
}
