//
//  appItemTableViewCell.swift
//  Demo
//
//  Created by 张祥军 on 2021/5/17.
//

import UIKit

class appItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet var starSuperView: UIView!
    @IBOutlet var itemCommentsLabel: UILabel!
    lazy var starView:StarsView = {
        let starView = StarsView(starSize: CGSize(width: 15,height: 15), space: 2, numberOfStar: 5)
        starView?.isUserInteractionEnabled = false
        return starView!
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.layer.cornerRadius = 20
        itemImage.layer.masksToBounds = true
        starSuperView.addSubview(starView)
    }
   
    func setData(model:entryCacheModel , cell:appItemTableViewCell , indexPath: IndexPath) -> Void {
        self.itemTitleLabel.text = model.itemTitle
        self.itemCategoryLabel.text = model.itemCategory
        self.itemImage.setImage(image:model.itemImage)
        self.itemCountLabel.text = String(indexPath.row + 1)
        self.starView.score = CGFloat(Int(arc4random() % 5) + 1);
        self.itemCommentsLabel.text = "(" + model.itemComments + ")"
    }
}
