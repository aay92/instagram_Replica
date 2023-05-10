//
//  FeedViewController.swift
//  instagram_Replica
//
//  Created by Aleksey Alyonin on 01.05.2023.
//

import UIKit
import SnapKit

protocol FeedViewDelegate {
    func sendTextOnDetailView(number: Int)
}

class FeedViewController: UIViewController {
    
    private let tableView = UITableView()
    
     var delegate: FeedViewDelegate? = nil
    
     var items: [FeedItemType] = [
        .stories([
            FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: true, isNewStory: false),
            FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: false, isNewStory: true),
            FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: false, isNewStory: true),
            FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: false, isNewStory: false),
            FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: false, isNewStory: false)]),
        .post(FeedPostItemInfo(userImage: UIImage(named: "sabaka")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "sabaka")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
        .post(FeedPostItemInfo(userImage: UIImage(named: "sabaka")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "sabaka")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
        .post(FeedPostItemInfo(userImage: UIImage(named: "sabaka")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "sabaka")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
        .post(FeedPostItemInfo(userImage: UIImage(named: "sabaka")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "sabaka")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
    ]
    
    var items1: [FeedItemType] = [
       .stories([
           FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: true, isNewStory: false),
           FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: false, isNewStory: true),
           FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: false, isNewStory: true),
           FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: false, isNewStory: false),
           FeedStoriesItemCellInfo(image: UIImage(named: "sabaka")!, userName: "user123", isAddButtonVisible: false, isNewStory: false)]),
       .post(FeedPostItemInfo(userImage: UIImage(named: "sabaka")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "sabaka")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
       .post(FeedPostItemInfo(userImage: UIImage(named: "sabaka")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "sabaka")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
       .post(FeedPostItemInfo(userImage: UIImage(named: "sabaka")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "sabaka")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
       .post(FeedPostItemInfo(userImage: UIImage(named: "sabaka")!, userName: "some_text", postSubTitle: "Sponsered", postImage: UIImage(named: "sabaka")!, numberOfLikes: 123, comment: CommentShortInfo(userName: "Author_god", commentText: "hahaha"))),
   ]
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()

    }
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

extension FeedViewController {
    func initialize() {

        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItems = makeLeftBarButtonItems()
        navigationItem.rightBarButtonItems = makeRightBarButtonItems()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorColor = .clear
        
        tableView.register(FeedStoriesSetCell.self, forCellReuseIdentifier: String(describing:FeedStoriesSetCell.self))
        tableView.register(FeedPostCell.self, forCellReuseIdentifier: String(describing: FeedPostCell.self))
      
        ///add object and constrain
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    ///Стрелка вниз c logo в верхнем левом углу это меню - Шеврон
    func makeLeftBarButtonItems() -> [UIBarButtonItem]{
        let logoBarItem = UIBarButtonItem(customView: LogoView())
        let dropDownButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.down"), target: self, action: nil, menu: makeDropDownMenu())
        return [logoBarItem, dropDownButtonItem]
    }
    
    func makeRightBarButtonItems() -> [UIBarButtonItem]{
        let addBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(didTapPlusButton))
        let directBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .plain, target: self, action: #selector(didTapDirectButton))
        return [addBarButtonItem, directBarButtonItem]
    }
    
    @objc func didTapPlusButton(){ print("Add") }
    @objc func didTapDirectButton(){ print("Direct") }
    
    ///Меню из двух пунктов
    func makeDropDownMenu() -> UIMenu {
        let subsItem = UIAction(title: "Подписки", image: UIImage(systemName: "person.2")) { _ in
            print("Subs")
            self.items = self.items1
            self.tableView.reloadData()
        }
        
        let faveItems = UIAction(title: "Избраное", image: UIImage(systemName: "srar")) { _ in
            print("Favorits")
        }
        return UIMenu(title: "", children: [subsItem, faveItems])
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case .stories(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedStoriesSetCell.self), for: indexPath) as! FeedStoriesSetCell
            cell.configure(with: info)
            return cell
        case .post(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedPostCell.self),for: indexPath) as! FeedPostCell
            cell.configure(with: post)
            return cell
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chagedImages = DetailViewController()
       
//        chagedImages.closure = { [weak self] (value) in
//            print("value \(value)")
//            self!.items = value
//        }
        self.delegate = chagedImages
        chagedImages.delegate = self
        let number = indexPath.item
        delegate?.sendTextOnDetailView(number: number)
        navigationController?.pushViewController(chagedImages, animated: true)
        
    }
}

extension FeedViewController: DetailViewDelegate {
    func getOtherMockData(items: [FeedItemType]) {
        self.items = items
        self.tableView.reloadData()
    }
}
