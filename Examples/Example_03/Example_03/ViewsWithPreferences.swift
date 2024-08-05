//  Created by Axel Ancona Esselmann on 8/4/24.
//

import SwiftUI
import UserPreferences

struct ShowAView: View {

    @UserPreference(ExampleKey.array)
    var array: Array<String> = []

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<array.count, id: \.self) { index in
                Text("\(index + 1): \(array[index])")
            }
        }
        .padding()
        .background(Color.random)
    }
}

struct SetAView: View {

    @UserPreference(ExampleKey.array)
    var array: Array<String> = []

    var body: some View {
        VStack(alignment: .leading) {
            Button("clear") {
                _array.reset()
            }
            ForEach(0...array.count, id: \.self) { index in
                HStack {
                    Button("", systemImage: "trash.fill") {
                        array.remove(at: index)
                    }.disabled(index >= array.count)
                    TextField(
                        "\(index)",
                        text: Binding(
                            get: {
                                if index < array.count {
                                    array[index]
                                } else {
                                    ""
                                }
                            }, set: {
                                if index < array.count {
                                    array[index] = $0
                                } else if !$0.isEmpty {
                                    array.append($0)
                                }
                            }
                        )
                    )
                }
            }
        }
        .padding()
        .background(Color.random)
    }
}
