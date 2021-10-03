//
//  Loadable.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import Foundation

public enum Loadable<T> {
    case success(data: T)
    case error(error: Error)
    case loading
}
public enum Downloadable<T> {
    case success(data: T)
    case error(error: Error)
    case loading(_ progress: Double)
}
