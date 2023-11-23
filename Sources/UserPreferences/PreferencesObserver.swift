//  Created by Axel Ancona Esselmann on 11/23/23.
//

import Combine

@MainActor
public class PreferencesObserver: ObservableObject {

    private var bag: AnyCancellable?

    public init() { }

    public init<Key>(_ preferences: UserPreferences<Key>) {
        observe(preferences)
    }

    @MainActor
    public func observe<Key>(_ preferences: UserPreferences<Key>) {
        bag = preferences.change.sink { change in
            self.objectWillChange.send()
        }
    }
}
