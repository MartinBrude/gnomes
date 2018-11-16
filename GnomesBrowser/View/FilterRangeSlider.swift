//
//  FilterRangeSlider.swift
//  GnomesBrowser
//
//  Created by Martin on 17/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import ZMSwiftRangeSlider

class FilterRangeSlider : RangeSlider {
    override func awakeFromNib() {
        super.awakeFromNib()
        trackTintColor = UIColor.gray
        tintColor = UIColor.primaryColor
        minValueThumbTintColor = UIColor.lightGray
        maxValueThumbTintColor = UIColor.lightGray
        trackHighlightTintColor = UIColor.primaryColor
        thumbSize = 24.0
        displayTextFontSize = 12.0
        thumbOutlineSize = 1.0
        trackHeight = 3.0
    }

    func config(minRangeValue : Int, maxRangeValue : Int, currentMinValue : Int, currentMaxValue : Int) {
        let range = Array(minRangeValue...maxRangeValue)
        setRangeValues(range)
        setMinAndMaxRange(minRangeValue, maxRange:maxRangeValue)
        setMinAndMaxValue(currentMinValue, maxValue: currentMaxValue)
    }
}


