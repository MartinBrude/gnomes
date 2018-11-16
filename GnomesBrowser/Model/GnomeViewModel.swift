//
//  GnomeViewModel.swift
//  GnomesBrowser
//
//  Created by Martin on 23/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import Foundation

class GnomeViewModel {
    var gnome : Gnome
    var visible : Bool

    init(gnome : Gnome, visible : Bool) {
        self.gnome = gnome
        self.visible = visible
    }
}
