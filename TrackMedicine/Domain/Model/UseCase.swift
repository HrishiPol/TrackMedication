//
//  UseCase.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import Foundation

protocol UseCase {
    associatedtype Output
    func execute() -> Output
}

protocol CompletableUseCase {
    func execute()
}

protocol CompletableUseCaseWithParameter {
    associatedtype Input
    func execute(input: Input)
}

protocol UseCaseWithParameter {
    associatedtype Input
    associatedtype Output
    func execute(input: Input) -> Output
}
