//  Created by Axel Ancona Esselmann on 8/5/24.
//

import SwiftUI

struct SetAView: View {

    @StateObject
    var vm: SetAViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Button("clear") {
                vm.reset()
            }
            ForEach(0...vm.count, id: \.self) { index in
                HStack {
                    Button("", systemImage: "trash.fill") {
                        vm.remove(at: index)
                    }.disabled(index >= vm.count)
                    TextField(
                        "\(index)",
                        text: vm[index]
                    )
                }
            }
        }
        .padding()
        .background(Color.random)
    }
}
