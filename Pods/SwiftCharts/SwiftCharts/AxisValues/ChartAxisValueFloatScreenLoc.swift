//
//  ChartAxisValueFloatScreenLoc.swift
//  SwiftCharts
//
//  Created by ischuetz on 30/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

@available(*, deprecated=0.2.5, message="use ChartAxisValueDoubleScreenLoc instead")
public class ChartAxisValueFloatScreenLoc: ChartAxisValueFloat {
    
    private let actualFloat: CGFloat
    
    var screenLocFloat: CGFloat {
        return CGFloat(self.scalar)
    }
    
    override public var text: String {
        return self.formatter.stringFromNumber(self.actualFloat)!
    }

    // screenLocFloat: model value which will be used to calculate screen position
    // actualFloat: scalar which this axis value really represents
    public init(screenLocFloat: CGFloat, actualFloat: CGFloat, formatter: NSNumberFormatter = ChartAxisValueFloat.defaultFormatter, labelSettings: ChartLabelSettings = ChartLabelSettings()) {
        self.actualFloat = actualFloat
        super.init(screenLocFloat, formatter: formatter, labelSettings: labelSettings)
    }
    
    override public var labels: [ChartAxisLabel] {
        let axisLabel = ChartAxisLabel(text: self.text, settings: self.labelSettings)
        return [axisLabel]
    }
}
