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
    var imageData: Data? = nil
    
    init(title: String, subTitle: String, imageURL: URL?) {
        
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
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
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let newsImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
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
                                      width: contentView.frame.size.width - 170,
                                      height: 70)
        
        newsSubTitleLabel.frame = CGRect(x: 10,
                                      y: 60,
                                      width: contentView.frame.size.width - 170,
                                      height: contentView.frame.size.height - 70)
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 160,
                                      y: 10,
                                      width: 150,
                                      height: contentView.frame.size.height - 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        newsTitleLabel.text = nil
        newsSubTitleLabel.text = nil
    }
    
    func configure (with viewModel: NewsTabelViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        newsSubTitleLabel.text = viewModel.subTitle

        // Image
        if let data = viewModel.imageData {
//            newsImageView.image = UIImage(data: data)
            print("OK")
        }
        else if let url = viewModel.imageURL {
            // fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    print("Good")
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                    print("Well")
                }
            }
        }
    }
}
