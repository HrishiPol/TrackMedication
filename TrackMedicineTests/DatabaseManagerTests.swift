//
//  TrackMedicineTests.swift
//  TrackMedicineTests
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import Quick
import Nimble
import Foundation
@testable import TrackMedicine
class DatabaseManagerTests: QuickSpec {
    override func spec() {
        var medication: Medication!
        var date = Date()
        describe("Test cases for DatabaseManager") {
            beforeEach {
                medication = Medication()
                medication.date = Date()
                date = medication.date ?? Date()
                medication.time = "11:00 am"
                medication.identifier = NotificationIdentifiers.morning.rawValue
                _ = DatabaseManager.shared.saveMedication(medication)
            }
            context("when medicine taken") {
                it("should have medication record.") {
                    expect(medication.date).to(equal(date))
                    expect(medication.date == Date()).to(beFalse())
                    expect(medication.time).to(equal("11:00 am"))
                    expect(medication.time == "11:01 am").to(beFalse())
                }
            }
        }
    }
}
