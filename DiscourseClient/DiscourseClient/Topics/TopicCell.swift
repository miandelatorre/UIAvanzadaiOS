//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var comentariosLabel: UILabel!
    @IBOutlet weak var visitasLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.viewDelegate = self
            
            userImage.layer.cornerRadius = 32
            userImage.layer.masksToBounds = true
            userImage?.image = viewModel.userImage;
            postLabel?.text = viewModel.postLabelText
            postLabel.text = viewModel.postLabelText
            comentariosLabel.text = viewModel.comentariosLabelText
            visitasLabel.text = viewModel.visitasLabelText
            
            let inputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "es_ES")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = inputFormat
            // Generar la fecha a partir del string y el formato de entrada
            guard let fechaEntrada = viewModel.fechaLabelText else {
                fechaLabel.text = nil
                return
            }
            guard let date = dateFormatter.date(from: fechaEntrada) else {
                fechaLabel.text = nil
                return
            }

            // Jan 20
            let outputFormat = "MMM yy"
            dateFormatter.dateFormat = outputFormat
            let outputStringDate = dateFormatter.string(from: date)
            fechaLabel.text = outputStringDate.capitalized
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension TopicCell: TopicCellViewModelViewDelegate {
    func userImageFetched() {
        userImage.layer.cornerRadius = 32
        userImage?.image = viewModel?.userImage;
        setNeedsLayout()
    }
}
