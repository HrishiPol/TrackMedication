//
//  Medication.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 3/10/21.
//
import Realm
import RealmSwift
import Foundation
class Medication: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var date: Date?
    @objc dynamic var time: String?
    @objc dynamic var identifier: NotificationIdentifiers.RawValue?
    override static func primaryKey() -> String? {
        return "id"
    }
}
func ==(lhs: Medication, rhs: Medication) -> Bool {
    return lhs.date == rhs.date
}
