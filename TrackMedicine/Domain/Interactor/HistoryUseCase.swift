//
//  HistoryUseCase.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 3/10/21.
//

import Foundation
import ReactiveSwift
class HistoryUseCase: UseCase {
    typealias Output = SignalProducer<Loadable<[Medication]?>, Never>
    
    init(string: String) {}
    func execute() -> SignalProducer<Loadable<[Medication]?>, Never> {
        return SignalProducer(value: Loadable.success(data: DatabaseManager.shared.getAllMedications()))
    }
}
