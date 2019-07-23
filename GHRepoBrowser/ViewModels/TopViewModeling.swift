//
//  ViewModel.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import Foundation

protocol TopViewModeling {
    var onViewModelFinished: (() -> Void)? { get set }
}
