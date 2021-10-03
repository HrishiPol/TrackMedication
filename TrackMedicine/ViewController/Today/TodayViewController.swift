//
//  TodayViewController.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import UIKit
import UserNotifications

class TodayViewController: UIViewController {
    var viewModel: TodayViewModel?
    var currentTimeIdentifier = NotificationIdentifiers.none
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var medicineTakenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewControllerContainer.resolve(TodayViewModel.self)
        medicineTakenButton.layer.cornerRadius = 12
        let result = viewModel?.greeting()
        if let greetingResult = result {
            greetingLabel.text = greetingResult.0
            currentTimeIdentifier = greetingResult.1
        }
        viewModel?.onLaunch.value = ""
        viewModel?.onTodayScoreLoaded.observeValues({ value in
            if let score = value {
                self.scoreLabel.text = score
                if let intScore = Int(score) {
                    self.scoreLabel.textColor = Utility.shared.getColorForScore(score: intScore)
                }
            } else {
                // Error
                self.scoreLabel.text = "0"
            }
        })
        
        viewModel?.onCheckMedications.observeValues({ result in
            if let isExits = result,
               isExits == false {
                guard let date = Utility.shared.getDate(),
                      let time = Utility.shared.getTime(),
                      let model = self.viewModel else {
                    return
                }
                let medication = Medication()
                medication.date = date
                medication.time = time
                medication.identifier = self.currentTimeIdentifier.rawValue
                model.onMedicationTaken.value = medication
                self.viewModel?.onLoadTodayScore.value = ""
            } else {
                var timeString = ""
                switch self.currentTimeIdentifier {
                case .morning:
                    timeString = "morning"
                case .afternoon:
                    timeString = "afternoon"
                case .evening:
                    timeString = "evening"
                default:
                    break
                }
                self.showAlertWithTitle(title: "Error", message: "Already taken \(timeString) medication.")
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.onLoadTodayScore.value = ""
    }
            
    @IBAction func medicineTakenButtonTapped(_ sender: UIButton) {
        viewModel?.onTapMedicationTaken.value = currentTimeIdentifier
    }
}
