//
//  TopicOfTheDayCell.swift
//  DiscourseClient
//
//  Created by Miguel Angel de la Torre on 01/06/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class TopicOfTheDayCell: UITableViewCell {

    var viewModel: TopicOfTheDayCellViewModel?
    
    @IBOutlet weak var yellowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        yellowView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
