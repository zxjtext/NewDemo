//
//  appItemTableViewCell.swift
//  Demo
//
//  Created by 张祥军 on 2021/5/17.
//

import UIKit
import RealmSwift

class appItemTableViewCell: UITableViewCell {
    let imageLoadQueu = OperationQueue()
    var imageOps = [(Item, Operation?)]()
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet var starSuperView: UIView!
    @IBOutlet var itemCommentsLabel: UILabel!
    var LookUpModelArray:[lookUpModelArray]?
    let realm = try! Realm()
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
        imageLoadQueu.maxConcurrentOperationCount = 2
        imageLoadQueu.qualityOfService = .userInitiated
        
    }
    
    func setData(model:entryCacheModel , cell:appItemTableViewCell , indexPath: IndexPath) -> Void {
        self.itemTitleLabel.text = model.itemTitle
        self.itemCategoryLabel.text = model.itemCategory
        self.itemImage.setImage(image:model.itemImage)
        self.itemCountLabel.text = String(model.itemCount+1)
        if model.updateBool{
            self.starView.score = CGFloat(model.starViewScore)
            self.itemCommentsLabel.text = "(" + (model.itemComments) + ")"
        }else{
          getRealmDB()
          let (item, operation) = imageOps[indexPath.row]
          operation?.cancel()
          let newOp = ImageLoadOperation(forItem: item) { (data) in
            DispatchQueue.main.async { [self] in
                self.setScoreAndComments(data: data,model: model)
             }
          }
          imageLoadQueu.addOperation(newOp)
          imageOps[indexPath.row] = (item, newOp)
       }
    }
}

extension appItemTableViewCell{
    func setScoreAndComments(data:Data?,model:entryCacheModel) -> Void {
        if var jsonString = String(data:data!, encoding: String.Encoding.utf8){
            jsonString = jsonString.replacingOccurrences(of: "im:", with: "")
            jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
            let tempModel = lookUpSuperModelArray.deserialize(from: jsonString)
            LookUpModelArray = (tempModel?.results!)
            self.itemCommentsLabel.text = "(" + (LookUpModelArray?.first?.userRatingCount ?? "") + ")"
            self.starView.score = CGFloat((LookUpModelArray?.first!.averageUserRating) ?? 0)
            let tempCacheModel = entryCacheModel(value: ["starViewScore":(LookUpModelArray?.first!.averageUserRating) ?? 0,"itemComments":(LookUpModelArray?.first?.userRatingCount ?? ""),"updateBool":true,"itemCount":model.itemCount,"itemCategory":model.itemCategory,"itemImage":model.itemImage,"summary":model.summary,"rights":model.rights,"itemTitle":model.itemTitle])
            try! realm.write {
                realm.add(tempCacheModel, update: .modified)
            }
            
        }
    }
}
extension appItemTableViewCell{
    func getRealmDB() -> Void{
        let allRealms = realm.objects(entryCacheModel.self)
        if allRealms.count != 0 {
            var tempAllRealmsArray = [entryCacheModel]()
            for model in allRealms {
                tempAllRealmsArray.append(model)
            }
            imageOps = Item.creatItems(CacheModelArray:tempAllRealmsArray).map({ (data) -> (Item, Operation?) in
                return (data, nil)
            })
        }
    }
}
