//
//  appItemHeadCollectionViewCell.swift
//  Demo
//
//  Created by 张祥军 on 2021/5/18.
//

import UIKit

class appItemHeadCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.layer.cornerRadius = 20
        itemImage.layer.masksToBounds = true
    }
    func setData(model:entryModelArray , cell:appItemHeadCollectionViewCell) -> Void {
        self.itemTitleLabel.text = model.title?.label
        self.itemCategoryLabel.text = model.category?.attributes?.label
        self.itemImage.setImage(image:model.image?.last?.label ?? "")
    }
}
