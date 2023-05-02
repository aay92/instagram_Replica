//
//  LogoView.swift
//  instagram_Replica
//
//  Created by Aleksey Alyonin on 01.05.2023.
//

import UIKit
import SnapKit

class LogoView: UIView {
    //MARK: - init LogoView
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    /// required init? - нужен для того чтобы запустить эту вью не их кода а из сториборда
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "instLogo")
        return view
    }()
    
    private enum UIConstants {
        static let logoWidth: CGFloat = 104
        static let ligiHight: CGFloat = 30
    }
}

private extension LogoView {
    func initialize(){
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIConstants.logoWidth)
            make.height.equalTo(UIConstants.ligiHight)
        }
    }
}
