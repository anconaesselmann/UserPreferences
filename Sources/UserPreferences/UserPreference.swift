//  Created by Axel Ancona Esselmann on 8/4/24.
//

import Foundation
import SwiftUI
import Combine

@propertyWrapper
public struct UserPreference<Key, Value>: DynamicProperty
    where
        Key: UserPreferenceKey,
        Key.RawValue == String,
        Value: PreferenceValue
{
    @StateObject
    private var vm: UserPreferenceWrapperModel<Key, Value>

    @EnvironmentObject
    private var store: UserPreferences<Key>

    public var wrappedValue: Value {
        get {
            vm.update(store: store)
            return vm.value
        }

        nonmutating
        set {
            vm.update(store: store)
            vm.value = newValue
        }
    }

    public var projectedValue: Binding<Value> {
        Binding { wrappedValue } set: { wrappedValue = $0 }
    }

    public init(
        wrappedValue defaultValue: Value,
        _ key: Key
    ) {
        _vm = StateObject(
            wrappedValue: UserPreferenceWrapperModel(
                key: key, defaultValue: defaultValue
            )
        )
    }
}

@MainActor
final internal class UserPreferenceWrapperModel<Key, Value>: ObservableObject
    where
        Key: UserPreferenceKey,
        Key.RawValue == String,
        Value: PreferenceValue
{
    private let key: Key
    private let defaultValue: Value
    private var store: UserPreferences<Key>?

    private var subscription: AnyCancellable?

    internal var value: Value {
        get {
            store?[key] ?? defaultValue
        }
        set {
            store?[key] = newValue
        }
    }

    internal func update(store: UserPreferences<Key>) {
        guard self.store == nil else {
            return
        }
        self.store = store
        subscription = store.change.eraseToAnyPublisher()
            .filter { [weak self] in
                ($0.key.rawValue as? String) == self?.key.rawValue
            }
            .sink { _ in
                self.objectWillChange.send()
            }
    }

    internal init(
        key: Key,
        defaultValue: Value
    ) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
