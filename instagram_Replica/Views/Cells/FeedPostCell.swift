//
//  FeedPostCell.swift
//  instagram_Replica
//
//  Created by Aleksey Alyonin on 02.05.2023.
//

import UIKit
import SnapKit

class FeedPostCell: UITableViewCell {
    func configure(with info: FeedPostItemInfo){
        userImageView.image = info.userImage
        userNameLabel.text = info.userName
        subTitleLabel.text = info.postSubTitle
        postImageView.image = info.postImage
        likeLabel.text = "\(info.numberOfLikes) likes"
        if let comment = info.comment {
            configureCommentLabel(with: comment)
        }
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    ///required init? - нужен для того что если появится xib или сториборд приложенрие не крашнулось
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum UIConstants {
        static let userImageSize: CGFloat = 30
        static let contentInset: CGFloat = 12
        static let userInsetTop: CGFloat = 6
        static let userNameLabel: CGFloat = 14
        static let subTitleLabel: CGFloat = 10
        static let userNameStack: CGFloat = 12
        static let postImageToUserOffset: CGFloat = 6
        static let actionStackHeight: CGFloat = 24
        static let actionStackToPostOffset: CGFloat = 6
        static let actionStackSpacing: CGFloat = 12
        static let actionStackToLiksLabelOffset: CGFloat = 12
        static let likeLabelFontSize: CGFloat = 14
        static let commentLabelFontSize: CGFloat = 12
        static let commentToLikesOffset: CGFloat = 12
    }
    
    //MARK: - private
    private let userImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = UIConstants.userImageSize / 2
        image.clipsToBounds = true
        return image
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.userNameLabel, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.subTitleLabel)
        label.textAlignment = .left
        return label
    }()
    
    private let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    private let postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return button
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.likeLabelFontSize, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.commentLabelFontSize)
        label.textAlignment = .left
        return label
    }()
}

//MARK: - private extension
private extension FeedPostCell {
    func initialize(){
        selectionStyle = .none
        contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.top.equalToSuperview().inset(UIConstants.userInsetTop)
            make.size.equalTo(UIConstants.userImageSize)
        }
        
        let userNameStack = UIStackView()
        userNameStack.axis = .vertical
        userNameStack.addArrangedSubview(userNameLabel)
        userNameStack.addArrangedSubview(subTitleLabel)
        
        contentView.addSubview(userNameStack)
        userNameStack.snp.makeConstraints { make in
            make.centerY.equalTo(userImageView)
            make.leading.equalTo(userImageView.snp.trailing).offset(UIConstants.userNameStack)
        }
        
        contentView.addSubview(optionsButton)
        optionsButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        contentView.addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(userImageView.snp.bottom).offset(UIConstants.postImageToUserOffset)
            make.height.equalTo(contentView.snp.width)
        }
        
        let actionStack = UIStackView()
        actionStack.axis = .horizontal
        actionStack.spacing = UIConstants.actionStackSpacing
        actionStack.addArrangedSubview(likeButton)
        actionStack.addArrangedSubview(commentButton)
        actionStack.addArrangedSubview(shareButton)
        
        contentView.addSubview(actionStack)
        actionStack.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.actionStackHeight)
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.top.equalTo(postImageView.snp.bottom).offset(UIConstants.actionStackToPostOffset)
        }
        
        contentView.addSubview(likeLabel)
        likeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.top.equalTo(actionStack.snp.bottom).offset(UIConstants.actionStackToLiksLabelOffset)
        }
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.top.equalTo(likeLabel.snp.bottom).offset(UIConstants.commentToLikesOffset)
            make.bottom.equalToSuperview().inset(7)
        }
    }
        
        func configureCommentLabel(with comment: CommentShortInfo) {
            let string = comment.userName + " " + comment.commentText
            let attributedString = NSMutableAttributedString(string: string)
            ///NSRange(location: .zero - от начала строки до length: comment.userName.count
            let range = NSRange(location: .zero, length: comment.userName.count)
            
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: UIConstants.commentLabelFontSize), range: range)
            
            commentLabel.attributedText = attributedString
        }
}
