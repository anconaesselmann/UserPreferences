//  Created by Axel Ancona Esselmann on 8/5/24.
//

import Foundation
import Combine

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

    var onUpdate: (() -> Void)?

    internal var value: Value {
        get {
            store?[key] ?? defaultValue
        }
        set {
            store?[key] = newValue
            onUpdate?()
        }
    }

    internal func update(store: UserPreferences<Key>) {
        guard self.store == nil else {
            return
        }
        self.store = store
        subscription = store.hasUpdated.eraseToAnyPublisher()
            .filter { [weak self] in
                ($0.rawValue as? String) == self?.key.rawValue
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

    internal func reset() {
        store?.reset(keys: [key])
    }
}
