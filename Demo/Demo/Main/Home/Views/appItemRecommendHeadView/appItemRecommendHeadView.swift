//
//  appItemRecommendHeadView.swift
//  Demo
//
//  Created by 张祥军 on 2021/5/18.
//

import UIKit

class appItemRecommendHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = (Bundle.main.loadNibNamed("appItemRecommendHeadView", owner: self, options: nil)?.last as! UIView)
        contentView.frame = frame
        addSubview(contentView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
