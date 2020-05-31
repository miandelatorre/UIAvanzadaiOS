//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
        
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            textLabel?.text = viewModel.textLabelText
            imageView.layer.cornerRadius = 40
            imageView?.image = viewModel.userImage
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        imageView?.image = viewModel?.userImage
        setNeedsLayout()
    }
}
