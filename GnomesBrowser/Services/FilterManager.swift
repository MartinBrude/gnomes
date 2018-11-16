//
//  FilterManager.swift
//  GnomesBrowser
//
//  Created by Martin on 19/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import UIKit

class FilterManager {

    var savedFilter : Filter?
    var memoryFilter = Filter()

    func config(ages : [Int], weights : [Int], heights : [Int]) {
        memoryFilter.minAge = savedFilter?.minAge ?? ages.min() ?? 0
        memoryFilter.maxAge = savedFilter?.maxAge ?? ages.max() ?? 0
        memoryFilter.minWeight = savedFilter?.minWeight ?? weights.min() ?? 0
        memoryFilter.maxWeight = savedFilter?.maxWeight ?? weights.max() ?? 0
        memoryFilter.minHeight = savedFilter?.minHeight ?? heights.min() ?? 0
        memoryFilter.maxHeight = savedFilter?.maxHeight ?? heights.max() ?? 0
    }

    func applyFilters(gnomes : [Gnome]) -> [Gnome] {
        var filtered = gnomes
            .filter{$0.age >= memoryFilter.minAge && $0.age <= memoryFilter.maxAge}
            .filter{$0.weight.ceilInt() >= memoryFilter.minWeight && $0.weight.floorInt() <= memoryFilter.maxWeight}
            .filter{$0.height.ceilInt() >= memoryFilter.minHeight && $0.height.floorInt() <= memoryFilter.maxHeight}

        if memoryFilter.friends.count > 0 {
            filtered = filtered.filter{$0.friends.contains(where: memoryFilter.friends.contains)}
        }
        if memoryFilter.professions.count > 0 {
            filtered = filtered.filter{$0.professions.contains(where: memoryFilter.professions.contains)}
        }
        if memoryFilter.hairColor.count > 0 {
            filtered = filtered.filter{memoryFilter.hairColor.contains($0.hairColor)}
        }

        return filtered
    }

    func saveFilter() {
        savedFilter = Filter(minAge : memoryFilter.minAge, maxAge : memoryFilter.maxAge, minWeight : memoryFilter.minWeight, maxWeight : memoryFilter.maxWeight, minHeight: memoryFilter.minHeight, maxHeight: memoryFilter.maxHeight, professions: memoryFilter.professions, hairColor: memoryFilter.hairColor, friends: memoryFilter.friends)
    }
    
    func resetToSavedFilter() {
        if let savedFilter = savedFilter {
            memoryFilter = savedFilter
        }
    }
}
