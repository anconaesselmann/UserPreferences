//  Created by Axel Ancona Esselmann on 11/20/23.
//

import Foundation

public struct PreferenceChange {
    var key: any PreferenceKey
    var oldValue: (any PreferenceValue)?
    var newValue: (any PreferenceValue)?
}
