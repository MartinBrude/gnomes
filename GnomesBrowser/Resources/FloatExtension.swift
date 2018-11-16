//
//  FloatExtension.swift
//  GnomesBrowser
//
//  Created by Martin on 26/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation

extension Float {
    func ceilInt() -> Int {
        return Int(ceilf(self))
    }
    func floorInt() -> Int {
        return Int(floor(self))
    }
}
