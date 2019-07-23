//
//  BasicLabel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class BasicLabel: UILabel {
    @objc dynamic var customFont: UIFont! {
        get { return self.font }
        set { self.font = newValue }
    }
    @objc dynamic var customColor: UIColor! {
        get { return self.textColor }
        set { self.textColor = newValue }
    }
}

class H0Label: BasicLabel {}
class H1Label: BasicLabel {}
class H2Label: BasicLabel {}
class H3Label: BasicLabel {}
