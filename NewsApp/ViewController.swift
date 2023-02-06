//
//  ViewController.swift
//  NewsApp
//
//  Created by GIORGI's MacPro on 06.02.23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTabelViewCell.self,
                       forCellReuseIdentifier: NewsTabelViewCell.identifier)
        return table
    }()
    
    private var viewModels = [NewsTabelViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News App"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        APICaller.shared.getTopNews { [weak self]result in
            switch  result {
                case .success(let articles):
                    self?.viewModels = articles.compactMap({
                        NewsTabelViewCellViewModel(title: $0.title,
                                                   subTitle: $0.description ?? "No Description",
                                                   imageURL: URL(string: $0.urlToImage ?? ""),
                                                   imageData: Data()
                        )
                    })
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTabelViewCell.identifier,
            for: indexPath) as? NewsTabelViewCell
        else {
           fatalError()
       }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
}


