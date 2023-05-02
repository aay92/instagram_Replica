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
        
        return image
    }()
    
    func configure(with info: FeedStoriesItemCellInfo){
        imageView.image = info.image
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
        static let imageSize: CGFloat = 160
        static let imageCellInset: CGFloat = 6
    }
}

private extension StoriesItemCell{
    func initialise(){
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(UIConstants.imageSize)
            make.leading.top.trailing.equalToSuperview().inset(UIConstants.imageCellInset)
            
        }
    }
}
