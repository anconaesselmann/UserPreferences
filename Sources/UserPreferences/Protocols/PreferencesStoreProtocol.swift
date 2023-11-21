//  Created by Axel Ancona Esselmann on 11/20/23.
//

import Foundation

public protocol PreferencesStoreProtocol {
    @MainActor
    func store(_ value: (any PreferenceValue)?, for key: any PreferenceKey) throws

    @MainActor
    func get<Value>(_ key: any PreferenceKey, for type: Value.Type) throws -> Value?
        where Value: PreferenceValue

    @MainActor
    func clearValue(for key: any PreferenceKey)
}
