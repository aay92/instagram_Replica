//
//  FeedPostItemInfo.swift
//  instagram_Replica
//
//  Created by Aleksey Alyonin on 02.05.2023.
//

import UIKit
struct FeedPostItemInfo {
    let userImage: UIImage
    let userName: String
    let postSubTitle: String
    let postImage: UIImage
    let numberOfLikes: Int
    let comment: CommentShortInfo?
}

struct CommentShortInfo {
    let userName: String
    let commentText: String
}

