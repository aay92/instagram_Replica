//
//  DetailViewController.swift
//  instagram_Replica
//
//  Created by Aleksey Alyonin on 09.05.2023.
//

import UIKit
import SnapKit

protocol DetailViewDelegate {
    func getOtherMockData(items: [FeedItemType])
}

class DetailViewController: UIViewController {
    
    var delegate: DetailViewDelegate? = nil
    private let atherMockData = AtherMockData()
    
    var closure : (([FeedItemType]) -> Void)?
    
    let buttonSendMockData: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        button.setTitle(" Data go ", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tabButtonSendMockData), for: .touchUpInside)
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    @objc func tabButtonSendMockData(){
        delegate?.getOtherMockData(items: atherMockData.items)
        closure?(atherMockData.items)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}

extension DetailViewController {
    
    private func initialize(){
        view.backgroundColor = .white        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        
        view.addSubview(buttonSendMockData)
        buttonSendMockData.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.center).offset((UIScreen.main.bounds.width / 2)-35)
        }
    }

}

extension DetailViewController: FeedViewDelegate {
    func sendTextOnDetailView(number: Int) {
        label.text = String("Hello" + " " + "\(number)")
    }
}




class AtherMockData {
    
    var items : [FeedItemType] = [
        .stories([
            FeedStoriesItemCellInfo(image: UIImage(named: "2")!, userName: "user123", isAddButtonVisible: true, isNewStory: false),
            FeedStoriesItemCellInfo(image: UIImage(named: "2")!, userName: "user123", isAddButtonVisible: false, isNewStory: false)]),
        .post(FeedPostItemInfo(userImage: UIImage(named: "2")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "2")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
        .post(FeedPostItemInfo(userImage: UIImage(named: "2")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "2")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
    ]

}
