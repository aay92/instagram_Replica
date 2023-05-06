//
//  StoriesItemCell.swift
//  instagram_Replica
//
//  Created by Aleksey Alyonin on 02.05.2023.
//

import UIKit
import SnapKit

class StoriesItemCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = UIConstants.imageSize / 2
        image.clipsToBounds = true
        return image
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.userNameFontSize)
        label.textAlignment = .center
        return label
    }()
    
    private let circleImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Icon")
        return image
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.backgroundColor = .white
        button.layer.cornerRadius = UIConstants.sizeButtonPlus / 1.3
//        button.clipsToBounds = false
        return button
    }()
    
    func configure(with info: FeedStoriesItemCellInfo){
        imageView.image = info.image
        userNameLabel.text = info.userName
        addButton.isHidden = !info.isAddButtonVisible
        circleImageView.isHidden = !info.isNewStory
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum UIConstants {
        static let imageSize: CGFloat = 59
        static let imageCellInset: CGFloat = 8
        static let labelCellInset: CGFloat = 8
        static let imageToLabelOfset: CGFloat = 10
        static let userNameFontSize: CGFloat = 12
        static let sizeButtonPlus: CGFloat = 20
        static let circleImageView: CGFloat = 72
    }
}

private extension StoriesItemCell{
    func initialise(){
//        backgroundColor = .black
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(UIConstants.imageSize)
            make.leading.top.trailing.equalToSuperview().inset(UIConstants.imageCellInset)
        }
        
        contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview().inset(UIConstants.labelCellInset)
            make.top.equalTo(imageView.snp.bottom).offset(UIConstants.imageToLabelOfset)
        }
        
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(imageView)
            make.size.equalTo(UIConstants.sizeButtonPlus)
        }
        
        contentView.addSubview(circleImageView)
        circleImageView.snp.makeConstraints { make in
            make.center.equalTo(imageView)
            make.size.equalTo(UIConstants.circleImageView)
        }
    }
}
