//
//  Array+Extention.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 3/10/21.
//

import Foundation
//extension Array where Element: Equatable {
//    var unique: [Element] {
//        var uniqueValues: [Element] = []
//        forEach { item in
//            guard !uniqueValues.contains(item) else { return }
//            uniqueValues.append(item)
//        }
//        return uniqueValues
//    }
//}
//extension Sequence where Iterator.Element: Hashable {
//    func unique() -> [Iterator.Element] {
//        var seen: [Iterator.Element: Bool] = [:]
//        return self.filter { seen.updateValue(true, forKey: $0) == nil }
//    }
//}
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
