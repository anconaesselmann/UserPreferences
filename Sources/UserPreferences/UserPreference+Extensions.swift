//  Created by Axel Ancona Esselmann on 8/5/24.
//

import SwiftUI

extension PublishedUserPreference {
    public func isSet<V>(
        _ value: V
    ) -> Binding<Bool>
        where Value == Set<V>
    {
        Binding {
            wrappedValue.contains(value)
        } set: {
            if $0 {
                wrappedValue.insert(value)
            } else {
                wrappedValue.remove(value)
            }
        }
    }

    public subscript<V>(
        isSet value: V
    ) -> Binding<Bool>
        where Value == Set<V>
    {
        isSet(value)
    }
}

extension UserPreference {
    public func isSet<V>(
        _ value: V
    ) -> Binding<Bool>
        where Value == Set<V>
    {
        Binding {
            wrappedValue.contains(value)
        } set: {
            if $0 {
                wrappedValue.insert(value)
            } else {
                wrappedValue.remove(value)
            }
        }
    }

    public subscript<V>(
        isSet value: V
    ) -> Binding<Bool>
        where Value == Set<V>
    {
        isSet(value)
    }
}
