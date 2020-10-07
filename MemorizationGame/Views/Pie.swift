//
//  Pie.swift
//  MemorizationGame
//
//  Created by Yahia Ewida on 10/6/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import SwiftUI

struct Pie : Shape {
    
    var startAngle : Angle
    var endAngle : Angle
    var clockwise : Bool
    func path (in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX , y: rect.midY)
        var p = Path()
        let radius = min(rect.width , rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)) ,
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        p.move(to: center)
        p.addLine(to: center)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return p
    }
    
    
}
