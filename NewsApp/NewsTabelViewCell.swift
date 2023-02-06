//
//  NewsUITabelViewCell.swift
//  NewsApp
//
//  Created by GIORGI's MacPro on 06.02.23.
//

import UIKit

class NewsTabelViewCellViewModel {
    let title: String
    let subTitle: String
    let imageURL: URL?
    var imageData: Data?
    
    init(title: String, subTitle: String, imageURL: URL?, imageData: Data?) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
        self.imageData = imageData
    }
}

class NewsTabelViewCell: UITableViewCell {
    static let identifier = "NewsTabelViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let newsSubTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.font = UIFont.italicSystemFont(ofSize: 15)
        return label
    }()
    
    private let newsImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubTitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.frame.size.width - 220,
                                      height: 70)
        
        newsSubTitleLabel.frame = CGRect(x: 10,
                                      y: 60,
                                      width: contentView.frame.size.width - 220,
                                      height: contentView.frame.size.height - 70)
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 200,
                                      y: 10,
                                      width: 180,
                                      height: contentView.frame.size.height - 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure (with viewModel: NewsTabelViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        newsSubTitleLabel.text = viewModel.subTitle

        // Image
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            // fetch
            URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
