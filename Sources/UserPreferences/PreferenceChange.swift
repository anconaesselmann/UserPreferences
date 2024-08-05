//  Created by Axel Ancona Esselmann on 11/20/23.
//

import Foundation

public struct PreferenceChange {
    public var key: any UserPreferenceKey
    public var oldValue: (any PreferenceValue)?
    public var newValue: (any PreferenceValue)?
}
