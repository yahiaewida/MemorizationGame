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
    var color : Color
    var type : ThemeType
    
    init(title : String, emojis : [String], color : Color,type : ThemeType) {
        self.title = title
        self.emojis = emojis
        self.color = color
        self.type = type
    }
}

enum ThemeType : String{
    case Haloween
    case Sports
    case Food
    
    static func getThemeByIndex(index : Int) -> ThemeType {
        switch index {
        case 0:
            return .Haloween
        case 1:
            return .Sports
        default:
            return .Food
        }
    }
}
