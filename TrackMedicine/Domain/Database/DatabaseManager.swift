//
//  DatabaseManager.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import Realm
import RealmSwift
import Foundation
class DatabaseManager {
    static let shared = DatabaseManager()
    
    /// Save medication to the database.
    /// - Parameter medication: medication object.
    /// - Returns: Returns bool true or false.
    func saveMedication(_ medication: Medication) -> Bool {
        let realm = try! Realm()
        let newValue = realm.objects(Medication.self).map{$0.id}.max() ?? 0
        medication.id = newValue  + 1
        try! realm.write {
            realm.add(medication, update: .all)
        }
        return true
    }
    
    /// Get all medications data from database.
    /// - Returns: Returns list of medications from database.
    func getAllMedications() -> [Medication] {
        do {
            let realm = try Realm()
            let medications = realm.objects(Medication.self)
            return medications.filter("date != nil").sorted(byKeyPath: "date", ascending: true).toArray()
        } catch {
            return []
        }
    }
    
    func getTodayScore() -> String {
        do {
            let realm = try Realm()
            let medications = realm.objects(Medication.self)
            guard let date = Utility.shared.getDate() else {
                return "0"
            }
            var score = 0
            let filterMedications = medications.filter("date == %@", date).toArray()
            for medication in filterMedications {
                if medication.identifier == NotificationIdentifiers.morning.rawValue {
                    score += 30
                } else if medication.identifier == NotificationIdentifiers.afternoon.rawValue {
                    score += 30
                } else {
                    score += 40
                }
            }
            return "\(score)"
        } catch {
            return "0"
        }
    }
    
    func checkIfMedicationsAlreadyExitsForIdentifier(identifier: NotificationIdentifiers) -> Bool {
        do {
            let realm = try Realm()
            let medications = realm.objects(Medication.self)
            guard let date = Utility.shared.getDate() else {
                return false
            }
            var isExits = false
            let filterMedications = medications.filter("date == %@ AND identifier == %@", date, identifier.rawValue).toArray()
            if filterMedications.count > 0 {
                isExits = true
            }
            return isExits
        } catch {
            return false
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}
