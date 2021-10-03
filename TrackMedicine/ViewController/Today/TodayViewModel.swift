//
//  TodayViewModel.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import UIKit
import Foundation
import ReactiveSwift

class TodayViewModel {
    let onLaunch = MutableProperty<String?>(nil)
    let onMedicationTaken = MutableProperty<Medication?>(nil)
    let onLoadTodayScore = MutableProperty<String?>(nil)
    let onTapMedicationTaken = MutableProperty<NotificationIdentifiers?>(nil)
    let onCheckMedications: Signal<Bool?, Never>
    let onTodayScoreLoaded: Signal<String?, Never>
    let todayUseCase: TodayUseCase
    init(useCase: TodayUseCase) {
        todayUseCase = useCase
        let (onTodayScoreLoaded, onTodayScoreLoadedObserver) = Signal<String?, Never>.pipe()
        self.onTodayScoreLoaded = onTodayScoreLoaded
        
        let (onCheckMedications, onCheckMedicationsObserver) = Signal<Bool?, Never>.pipe()
        self.onCheckMedications = onCheckMedications
        
        let onTapMedicationTakenResult = onTapMedicationTaken.signal.flatMap(.latest) { (identifier) -> SignalProducer<Loadable<Bool?>, Never> in
            guard let id = identifier else {
                return SignalProducer(value: Loadable.success(data: false))
            }
            return self.todayUseCase.checkIfMedicationTakenForIdentifier(id)
        }

        onTapMedicationTakenResult.observeValues { (result) in
            switch result {
            case .success(let data):
                onCheckMedicationsObserver.send(value: data)
            case .error(let error):
                onCheckMedicationsObserver.send(value: nil)
                debugPrint(error.localizedDescription)
                break
            case .loading:
                break
            }
        }

        let onLaunchResult = onLaunch.signal.flatMap(.latest) { (_) -> SignalProducer<Loadable<Bool?>, Never> in
            return self.todayUseCase.execute(input: "")
        }

        onLaunchResult.observeValues { (result) in
            switch result {
            case .success(_):
                break
            case .error(let error):
                debugPrint(error.localizedDescription)
                break
            case .loading:
                break
            }
        }
        
        let onMedicationTakenResult = onMedicationTaken.signal.flatMap(.latest) { (medication) -> SignalProducer<Loadable<Bool?>, Never> in
            guard let medicine = medication else {
                return SignalProducer(value: Loadable.success(data: false))
            }
            return self.todayUseCase.medicationTaken(medication: medicine)
        }

        onMedicationTakenResult.observeValues { (result) in
            switch result {
            case .success(_):
                break
            case .error(let error):
                debugPrint(error.localizedDescription)
                break
            case .loading:
                break
            }
        }
        let onLoadTodayScoreResult = onLoadTodayScore.signal.flatMap(.latest) { (_) -> SignalProducer<Loadable<String?>, Never> in
            return self.todayUseCase.loadTodayScore()
        }

        onLoadTodayScoreResult.observeValues { (result) in
            switch result {
            case .success(let data):
                onTodayScoreLoadedObserver.send(value: data)
            case .error(let error):
                debugPrint(error.localizedDescription)
                onTodayScoreLoadedObserver.send(value: nil)
                break
            case .loading:
                break
            }
        }
    }
    
    func greeting() -> (String, NotificationIdentifiers) {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!
        var greeting = ""
        var notificationIdentifier = NotificationIdentifiers.none
        if hourInt >= 12 && hourInt <= 16 {
            greeting = "Good Afternoon"
            notificationIdentifier = .afternoon
        }
        else if hourInt >= 7 && hourInt <= 12 {
            greeting = "Good Morning"
            notificationIdentifier = .morning
        }
        else if hourInt >= 16 && hourInt <= 20 {
            greeting = "Good Evening"
            notificationIdentifier = .evening
        }
        else {
            greeting = "Good Night"
        }
        return (greeting, notificationIdentifier)
    }
}
