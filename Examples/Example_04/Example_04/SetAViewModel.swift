//  Created by Axel Ancona Esselmann on 8/5/24.
//

import SwiftUI
import UserPreferences

@MainActor
class SetAViewModel: ObservableObject {

    @PublishedUserPreference(ExampleKey.array)
    var array: Array<String> = []

    init(store: UserPreferences<ExampleKey>) {
        _array.use(store, updateOnChange: self)
    }

    public subscript(
        index: Int
    ) -> Binding<String> {
        Binding(
            get: { [weak self] in
                guard
                    let array = self?.array,
                    index < array.count
                else {
                    return ""
                }
                return array[index]
            }, set: { [weak self] in
                guard let count = self?.array.count else {
                    return
                }
                if index < count {
                    self?.array[index] = $0
                } else if !$0.isEmpty {
                    self?.array.append($0)
                }
            }
        )
    }

    var count: Int {
        array.count
    }

    func reset() {
        _array.reset()
    }

    func remove(at index: Int) {
        array.remove(at: index)
    }
}
