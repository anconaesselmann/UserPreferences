//  Created by Axel Ancona Esselmann on 11/20/23.
//

import Foundation

public protocol PreferenceKey: CaseIterable, Hashable, RawRepresentable
    where Self.RawValue == String
{ }
