//
//  ViewControllerContainer.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import Swinject
import Foundation
let viewControllerContainer = Container { container in
    container.register(TodayUseCase.self) { resolver in
        let useCase = TodayUseCase(string: "")
        return useCase
    }.inObjectScope(.container)
    container.register(TodayViewModel.self) { resolver in
        let useCase = resolver.resolve(TodayUseCase.self)!
        return  TodayViewModel(useCase: useCase)
    }
    container.register(HistoryUseCase.self) { resolver in
        let useCase = HistoryUseCase(string: "")
        return useCase
    }.inObjectScope(.container)
    container.register(HistoryViewModel.self) { resolver in
        let useCase = resolver.resolve(HistoryUseCase.self)!
        return  HistoryViewModel(useCase: useCase)
    }

}
