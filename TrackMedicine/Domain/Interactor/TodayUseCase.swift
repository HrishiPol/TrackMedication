//
//  TodayUseCase.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import Foundation
import ReactiveSwift
class TodayUseCase: UseCaseWithParameter {
    typealias Input = String
    typealias Output = SignalProducer<Loadable<Bool?>, Never>
    
    init(string: String) {}
    func execute(input: String) -> SignalProducer<Loadable<Bool?>, Never> {
        NotificationManager.shared.schedule()
        return SignalProducer(value: Loadable.success(data: true))
    }
    
    func medicationTaken(medication: Medication) -> SignalProducer<Loadable<Bool?>, Never> {
        return SignalProducer(value: Loadable.success(data: DatabaseManager.shared.saveMedication(medication)))
    }
    
    func loadTodayScore() -> SignalProducer<Loadable<String?>, Never> {
        return SignalProducer(value: Loadable.success(data: DatabaseManager.shared.getTodayScore()))
    }
    
    func checkIfMedicationTakenForIdentifier(_ identifier: NotificationIdentifiers) -> SignalProducer<Loadable<Bool?>, Never> {
        return SignalProducer(value: Loadable.success(data: DatabaseManager.shared.checkIfMedicationsAlreadyExitsForIdentifier(identifier: identifier)))
    }
}
