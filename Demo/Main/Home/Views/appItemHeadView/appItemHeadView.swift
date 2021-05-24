//
//  appItemHeadView.swift
//  Demo
//
//  Created by 张祥军 on 2021/5/18.
//

import UIKit

class appItemHeadView: UIView {
    @IBOutlet var appItemCollectionView: UICollectionView!
    var topItemArry:[entryModelArray]?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let contentView = (Bundle.main.loadNibNamed("appItemHeadView", owner: self, options: nil)?.last as! UIView)
        contentView.frame = frame
        addSubview(contentView)
        setUI()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension appItemHeadView:UICollectionViewDelegate,UICollectionViewDataSource{
    func setUI(){
        appItemCollectionView.register(UINib(nibName: "appItemHeadCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NSStringFromClass(appItemHeadCollectionViewCell.self))
        appItemCollectionView.showsHorizontalScrollIndicator = false
        appItemCollectionView.showsVerticalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing=20
        layout.itemSize = CGSize(width:100, height:170)
        layout.scrollDirection = .horizontal
        appItemCollectionView.collectionViewLayout = layout
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tempArray = topItemArry else {
            return 0
        }
        return tempArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:appItemHeadCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(appItemHeadCollectionViewCell.self), for: indexPath) as! appItemHeadCollectionViewCell
        guard let tempArray = topItemArry else {
            return cell
        }
        let model = tempArray[indexPath.row]
        cell.setData(model: model, cell: cell)
        return cell
    }
}
extension appItemHeadView{
    func loadData(){
        ViewModel.shared.fetchGrossingApplicationsData { (data) in
            guard let tempArray = data else {
                return
            }
            self.topItemArry = (tempArray as! topGrossingApplicationsModelArray).entry
            self.appItemCollectionView.reloadData()
        }
    }
}
