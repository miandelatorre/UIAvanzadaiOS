//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        table.register(UINib(nibName: "TopicOfTheDayCell", bundle: nil), forCellReuseIdentifier: "TopicOfTheDayCell")
//        table.estimatedRowHeight = 100
//        table.rowHeight = 96
        return table
    }()

    let viewModel: TopicsViewModel

    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let button = UIButton(frame: CGRect(x: 296, y: 653, width: 64, height: 64))
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.setImage(UIImage.init(named: "icoNew"), for: .normal)
        
        self.view.addSubview(button)
        
        guard let superview = view.superview else { return }
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
        ])

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewWasLoaded()
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }

    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item != 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
                let cellViewModel = viewModel.viewModel(at: indexPath) as? TopicCellViewModel {
                
                var userImageUrl: String?
                
                for user in viewModel.users {
                    if user.username == cellViewModel.lastPosterUsername {
                        userImageUrl = user.avatarTemplate
                    }
                }
                
                cellViewModel.userImageUrl = userImageUrl
                
                cellViewModel.setImage()
                
                cell.viewModel = cellViewModel
                return cell
            
            }
        } else {
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicOfTheDayCell", for: indexPath) as? TopicOfTheDayCell,
                let cellViewModel = viewModel.viewModel(at: indexPath) as? TopicOfTheDayCellViewModel {
                
                cell.viewModel = cellViewModel
                
                return cell
            }
        }

        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 151
        } else {
            return 96
        }
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        tableView.reloadData()
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
}
