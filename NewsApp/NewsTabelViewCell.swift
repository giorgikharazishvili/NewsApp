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
    let imageData: Data?
    
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
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let newsSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let newsImageView: UIImageView  = {
        let newsImageView = UIImageView()
        newsImageView.backgroundColor = .systemRed
        newsImageView.contentMode = .scaleAspectFit
        return newsImageView
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
        }
    }
}
