//  Created by Axel Ancona Esselmann on 8/4/24.
//

import SwiftUI
import UserPreferences

struct ShowAView: View {

    @UserPreference(ExampleKey.set)
    var set: Set<Int> = []

    var body: some View {
        VStack {
            ForEach(0..<10, id: \.self) {
                if set.contains($0) {
                    Text("\($0): On")
                } else {
                    Text("\($0): Off")
                }
            }
        }
        .padding()
        .background(Color.random)
    }
}

struct SetAView: View {

    @UserPreference(ExampleKey.set)
    var set: Set<Int> = []

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10, id: \.self) { index in
                Toggle(
                    "\(index) is \(set.contains(index) ? "set" : "not set")",
                    isOn: Binding(
                        get: {
                            set.contains(index)
                        }, set: {
                            if $0 {
                                set.insert(index)
                            } else {
                                set.remove(index)
                            }
                        }
                    )
                )
            }
        }
        .padding()
        .background(Color.random)
    }
}
