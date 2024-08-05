//  Created by Axel Ancona Esselmann on 8/4/24.
//

import Foundation
import SwiftUI

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

    public func reset() {
        vm.reset()
    }
}
