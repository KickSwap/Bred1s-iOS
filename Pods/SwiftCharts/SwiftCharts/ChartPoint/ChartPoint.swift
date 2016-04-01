//
//  ChartPoint.swift
//  swift_charts
//
//  Created by ischuetz on 01/03/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public class ChartPoint: Equatable {
    
    public let x: ChartAxisValue
    public let y: ChartAxisValue
    
    required public init(x: ChartAxisValue, y: ChartAxisValue) {
        self.x = x
        self.y = y
    }
    
    public var text: String {
        return "\(self.x.text), \(self.y.text)"
    }
}

public func ==(lhs: ChartPoint, rhs: ChartPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}