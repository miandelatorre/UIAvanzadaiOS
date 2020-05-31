//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol TopicCellViewModelViewDelegate: class {
    func userImageFetched()
}

/// ViewModel que representa un topic en la lista
class TopicCellViewModel {
    weak var viewDelegate: TopicCellViewModelViewDelegate?
    let topic: Topic
    var lastPosterUsername: String?
    var userImageUrl: String?
    var userImage: UIImage?
    var postLabelText: String?
    var comentariosLabelText: String?
    var visitasLabelText: String?
    var fechaLabelText: String?

    init(topic: Topic) {
        self.topic = topic
        
        lastPosterUsername = topic.lastPosterUsername
        postLabelText = topic.title
        comentariosLabelText = String(topic.postsCount)
        visitasLabelText = String(topic.posters.count)
        fechaLabelText = topic.lastPostedAt
    }
    
    func setImage(){
        var imageStringURL = "https://mdiscourse.keepcoding.io"
        
        guard let userImageUrlLoc = userImageUrl  else {
            userImage = nil
            return
        }
                
        imageStringURL.append(userImageUrlLoc.replacingOccurrences(of: "{size}", with: "100"))
            
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let url = URL(string: imageStringURL), let data = try? Data(contentsOf: url) {
                    self?.userImage = UIImage(data: data)
                    DispatchQueue.main.async {
                        self?.viewDelegate?.userImageFetched()
                    }
                }
        }
        
    }
}
