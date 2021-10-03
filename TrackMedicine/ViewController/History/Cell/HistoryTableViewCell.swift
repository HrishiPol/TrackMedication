//
//  HistoryTableViewCell.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var morningStackView: UIStackView!
    @IBOutlet weak var afternoonStackView: UIStackView!
    @IBOutlet weak var eveningStackView: UIStackView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var eveningLabel: UILabel!
    @IBOutlet weak var eveningTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
