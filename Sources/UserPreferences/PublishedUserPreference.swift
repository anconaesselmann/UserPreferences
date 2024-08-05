//  Created by Axel Ancona Esselmann on 8/5/24.
//

import SwiftUI
import Combine

@MainActor
@propertyWrapper
public struct PublishedUserPreference<Key, Value>: DynamicProperty
    where
        Key: UserPreferenceKey,
        Key.RawValue == String,
        Value: PreferenceValue
{
    private var vm: UserPreferenceWrapperModel<Key, Value>

    private let publisher = PassthroughSubject<Value, Never>()

    public var wrappedValue: Value {
        get { vm.value }

        nonmutating
        set {
            vm.value = newValue
            publisher.send(newValue)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
      publisher.eraseToAnyPublisher()
    }

    public init(
        wrappedValue defaultValue: Value,
        _ key: Key
    ) {
        vm = UserPreferenceWrapperModel(
            key: key, defaultValue: defaultValue
        )
    }

    public func reset() {
        vm.reset()
    }

    public func use(_ store: UserPreferences<Key>) {
        vm.update(store: store)
    }

    public func updateOnChange<T>(_ value: T)
        where
            T: ObservableObject,
            T.ObjectWillChangePublisher == ObservableObjectPublisher
    {
        vm.onUpdate = { [weak value] in
            value?.objectWillChange.send()
        }
    }

    public func use<T>(_ store: UserPreferences<Key>, updateOnChange value: T)
        where
            T: ObservableObject,
            T.ObjectWillChangePublisher == ObservableObjectPublisher
    {
        vm.update(store: store)
        updateOnChange(value)
    }
}
