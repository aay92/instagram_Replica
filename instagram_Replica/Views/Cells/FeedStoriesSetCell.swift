//
//  FeedStoriesSetCell.swift
//  instagram_Replica
//
//  Created by Aleksey Alyonin on 02.05.2023.
//

import UIKit
import SnapKit

class FeedStoriesSetCell: UITableViewCell {
    
    func configure(with info: FeedStoriesCellInfo){
        self.items = info
        print(info)
        collectionView.reloadData()
    }
    ///обьявили о collectionView
    private var collectionView: UICollectionView!
    private var items: FeedStoriesCellInfo = []
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private enum UIConstants {
        static let collectionViewHight: CGFloat = 106
        static let cellWidth: CGFloat = 72
        static let cellHeight: CGFloat = 98
    }
}

//MARK: - Private methods
///private extension - Все методы будут приватными
private extension FeedStoriesSetCell {
    func initialize(){
        let layout = UICollectionViewFlowLayout()
        ///инитиализируем collectionView (.zero - не важен фрейм при инит)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StoriesItemCell.self, forCellWithReuseIdentifier: String(describing: StoriesItemCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.addSubview(contentView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(105)
        }
    }
}
//MARK: - UICollectionViewDataSource
extension FeedStoriesSetCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StoriesItemCell.self), for: indexPath) as! StoriesItemCell
        cell.configure(with: items[indexPath.item])
        
        return cell
    }
}

extension FeedStoriesSetCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
    }
}