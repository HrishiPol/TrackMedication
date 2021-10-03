//
//  HistoryViewController.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var listTableView: UITableView!
    var viewModel: HistoryViewModel?
    var medicationList = [Medication]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewControllerContainer.resolve(HistoryViewModel.self)
        // Register cell for table view.
        listTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "HistoryTableViewCell")
        
        // Hide empty lines of table view.
        listTableView.tableFooterView = UIView()
        listTableView.separatorStyle = .none
        
        // Show header on top.
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 16, width: listTableView.frame.size.width - 32, height: 40))
        headerLabel.text = "History"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        headerLabel.textColor = UIColor(red: 10.0/255.0, green: 35.0/255.0, blue: 78.0/255.0, alpha: 1.0)
        listTableView.tableHeaderView = headerLabel
        
        viewModel?.onListLoaded.observeValues({ list in
            if let medications = list {
                self.medicationList.removeAll()
                var previousDate: Date?
                for item in medications {
                    if previousDate == nil {
                        self.medicationList.append(item)
                    } else if item.date != previousDate {
                        self.medicationList.append(item)
                    }
                    previousDate = item.date
                }
                self.listTableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.onLoadList.value = ""
    }
    
    //MARK: UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medicationList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        let medication = medicationList[indexPath.row]
        if let date = medication.date,
           let medications = viewModel?.dataForDate(date: date) {
            var index = 0
            var score = 0
            for item in medications {
                switch index {
                case 0:
                    cell.firstLabel.text = item.identifier ?? ""
                    cell.firstTimeLabel.text = item.time ?? ""
                case 1:
                    cell.secondLabel.text = item.identifier ?? ""
                    cell.secondTimeLabel.text = item.time ?? ""
                case 2:
                    cell.eveningLabel.text = item.identifier ?? ""
                    cell.eveningTimeLabel.text = item.time ?? ""
                default:
                    break
                }
                if item.identifier == NotificationIdentifiers.morning.rawValue {
                    score += 30
                } else if item.identifier == NotificationIdentifiers.afternoon.rawValue {
                    score += 30
                } else {
                    score += 40 
                }
                index += 1
            }
            if index == 1 {
                cell.afternoonStackView.isHidden = true
                cell.eveningStackView.isHidden = true
            } else if index == 2 {
                cell.eveningStackView.isHidden = true
            } else if index == 0 {
                cell.morningStackView.isHidden = true
                cell.afternoonStackView.isHidden = true
                cell.eveningStackView.isHidden = true
            } else {
                cell.morningStackView.isHidden = false
                cell.afternoonStackView.isHidden = false
                cell.eveningStackView.isHidden = false
            }
            cell.scoreLabel.text = "\(score)"
            cell.scoreLabel.textColor = Utility.shared.getColorForScore(score: score)
        }
        cell.selectionStyle = .none
        return cell
    }
}
