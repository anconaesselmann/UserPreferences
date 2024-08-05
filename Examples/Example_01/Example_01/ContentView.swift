//  Created by Axel Ancona Esselmann on 8/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                ShowAView()
                SetAView()
            }
            HStack {
                ShowBView()
                SetBView()
            }
        }
        .padding()
        .background(Color.random)
    }
}

