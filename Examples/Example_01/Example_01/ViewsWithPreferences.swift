//  Created by Axel Ancona Esselmann on 8/4/24.
//

import SwiftUI
import UserPreferences

struct ShowAView: View {

    @UserPreference(ExampleKey.aIsOn)
    var aIsOn: Bool = false

    var body: some View {
        VStack {
            Text(aIsOn ? "On" : "Off")
        }
        .padding()
        .background(Color.random)
    }
}

struct SetAView: View {

    @UserPreference(ExampleKey.aIsOn)
    var aIsOn: Bool = false

    var body: some View {
        VStack {
            Toggle(
                "Set aIsOn",
                isOn: $aIsOn
            )
        }
        .padding()
        .background(Color.random)
    }
}

struct ShowBView: View {

    @UserPreference(ExampleKey.bIsOn)
    var bIsOn: Bool = false

    var body: some View {
        VStack {
            VStack {
                Text(bIsOn ? "On" : "Off")
            }
        }
        .padding()
        .background(Color.random)
    }
}

struct SetBView: View {

    @UserPreference(ExampleKey.bIsOn)
    var bIsOn: Bool = false

    var body: some View {
        VStack {
            Toggle(
                "Set bIsOn",
                isOn: $bIsOn
            )
        }
        .padding()
        .background(Color.random)
    }
}
