//  Created by Axel Ancona Esselmann on 8/4/24.
//

import SwiftUI
import UserPreferences

struct ContentView: View {

    @EnvironmentObject
    private var store: UserPreferences<ExampleKey>

    var body: some View {
        VStack {
            HStack {
                ShowAView()
                let vm = SetAViewModel(store: store)
                SetAView(vm: vm)
            }
        }
        .padding()
        .background(Color.random)
    }
}

