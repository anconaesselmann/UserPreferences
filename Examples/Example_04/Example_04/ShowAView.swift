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
