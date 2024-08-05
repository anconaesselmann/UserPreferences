//  Created by Axel Ancona Esselmann on 8/4/24.
//

import SwiftUI
import UserPreferences

enum ExampleKey: String, UserPreferenceKey {
    case aIsOn, bIsOn
}

@main
struct Example_01App: App {

    @StateObject
    var preferences = UserPreferences<ExampleKey>()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(preferences)
        }
    }
}
