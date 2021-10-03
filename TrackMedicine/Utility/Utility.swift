//
//  Utility.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 3/10/21.
//

import UIKit
import Foundation
class Utility {
    static let shared = Utility()
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: Date())
        return dateFormatter.date(from: dateString)
    }
    
    func getTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: Date())
    }
    
    func getColorForScore(score: Int) -> UIColor {
        var color = UIColor()
        if score < 60 {
            color = UIColor(red: 197.0/255.0, green: 97.0/255, blue: 89.0/255.0, alpha: 1.0)
        } else if score > 60 || score < 70 {
            color = UIColor(red: 223.0/255.0, green: 166.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        } else {
            color = UIColor(red: 146.0/255.0, green: 216.0/255.0, blue: 93.0/255.0, alpha: 1.0)
        }
        return color
    }    
}
