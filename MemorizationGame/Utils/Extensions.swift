//
//  Extensions.swift
//  MemorizationGame
//
//  Created by Yahya Ewida on 9/7/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import Foundation


extension Array where Element : Identifiable{
    func firstIndex(of element :Element) -> Int?{
        for index in 0..<self.count{
               if self[index].id == element.id{
                   return index
               }
           }
           return nil
       }
}


extension Array {
    var only : Element? {
        (count == 1) ? first : nil
    }
}
