//  Created by Axel Ancona Esselmann on 11/17/23.
//

import Foundation
import Combine

@MainActor
public class UserPreferences<Key>: ObservableObject
    where Key: UserPreferenceKey
{

    public enum Error: Swift.Error {
        case storeError(Swift.Error)
    }

    public let change = PassthroughSubject<PreferenceChange, Never>()
    public let errors = PassthroughSubject<Error, Never>()

    private var store: PreferencesStoreProtocol

    public init(_ store: PreferencesStoreProtocol = UserDefaultsPreferencesStore.shared) {
        self.store = store
    }

    public subscript<Value>(
        key: Key,
        default defaultValue: Value
    ) -> Value
        where Value: PreferenceValue
    {
        self[key, as: Value.self] ?? defaultValue
    }

    public subscript<Value>(
        key: Key,
        as type: Value.Type? = nil
    ) -> Value?
        where Value: PreferenceValue
    {
        get {
            do {
                return try store.get(key, for: Value.self)
            } catch {
                store.clearValue(for: key)
                assertionFailure("Retrieving incompatible value for key \(key)")
                errors.send(.storeError(error))
                return nil
            }
        }
        set {
            do {
                let oldValue = try store.get(key, for: Value.self)
                try store.store(newValue, for: key)
                if !equal(oldValue, newValue) {
                    change.send(.init(key: key, oldValue: oldValue, newValue: newValue))
                }
            } catch {
                errors.send(.storeError(error))
            }

        }
    }

    public func resetAll() {
        for key in Key.allCases {
            store.clearValue(for: key)
        }
    }

    public func reset(keys: [Key]) {
        for key in keys {
            store.clearValue(for: key)
        }
    }

    public func reset<Value>(key: Key, for type: Value.Type) throws 
        where Value: PreferenceValue
    {
        let oldValue = try store.get(key, for: Value.self)
        store.clearValue(for: key)
        if oldValue != nil {
            change.send(.init(key: key, oldValue: oldValue, newValue: nil))
        }
    }

    public func reset(except excluded: [Key]) {
        let keys = Key.allCases.filter {
            !excluded.contains($0)
        }
        reset(keys: keys)
    }
}

// Also in LoadableView but without optional values
private func equal(_ a0: Any?, _ a1: Any?) -> Bool {
    if a0 == nil, a1 == nil {
        return true
    }
    guard
        let e0 = a0 as? any Equatable,
        let e1 = a1 as? any Equatable
    else {
        return false
    }
    return e0.isEqual(e1)
}

private extension Equatable {
    func isEqual(_ other: any Equatable) -> Bool {
        if let other = other as? Self {
            return self == other
        } else {
            return false
        }
    }
}
