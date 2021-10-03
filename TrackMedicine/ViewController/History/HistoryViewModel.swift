//
//  HistoryViewModel.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 3/10/21.
//

import UIKit
import Foundation
import ReactiveSwift

class HistoryViewModel {
    let historyUseCase: HistoryUseCase
    let onLoadList = MutableProperty<String?>(nil)
    let onListLoaded: Signal<[Medication]?, Never>
    var medications: [Medication]?
    init(useCase: HistoryUseCase) {
        historyUseCase = useCase
        let (onListLoaded, onListLoadedObserver) = Signal<[Medication]?, Never>.pipe()
        self.onListLoaded = onListLoaded

        let onLaunchResult = onLoadList.signal.flatMap(.latest) { (_) -> SignalProducer<Loadable<[Medication]?>, Never> in
            return self.historyUseCase.execute()
        }

        onLaunchResult.observeValues { (result) in
            switch result {
            case .success(let data):
                self.medications?.removeAll()
                self.medications = data
                onListLoadedObserver.send(value: data)
            case .error(let error):
                debugPrint(error.localizedDescription)
                onListLoadedObserver.send(value: nil)
                break
            case .loading:
                break
            }
        }
    }
    
    func dataForDate(date: Date) -> [Medication] {
        if let list = medications {
            let filterdList = list.filter { $0.date == date }
            return filterdList
        }
        return []
    }
}
