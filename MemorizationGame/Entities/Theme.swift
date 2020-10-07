//
//  Theme.swift
//  MemorizationGame
//
//  Created by Yahia Ewida on 10/7/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import Foundation
import SwiftUI

struct Theme {
    var title : String
    var emojis : [String]
    var color : UIColor
    
    init(title : String, emojis : [String], color : UIColor) {
        self.title = title
        self.emojis = emojis
        self.color = color
    }
}

enum ThemeType {
    case Haloween
    case Sports
    case Food
}
