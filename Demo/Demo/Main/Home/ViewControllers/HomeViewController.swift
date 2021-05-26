//
//  HomeViewController.swift
//  Demo
//
//  Created by 张祥军 on 2021/5/17.
//

import UIKit
import RealmSwift


@available(iOS 11.0, *)
class HomeViewController: BaseViewController {
    var searchC: UISearchController!
    @IBOutlet var tableView: UITableView!
    var topItemArry = [entryCacheModel](){
        didSet  {self.tableView.reloadData()}
    }
    var allRealmsArray:[entryCacheModel]?
    var index: Int = 10
    lazy var ItemHeadView:appItemHeadView = {
        let ItemHeadView = appItemHeadView()
        return ItemHeadView
    }()
    lazy var RecommendHeadView:appItemRecommendHeadView = {
        let RecommendHeadView = appItemRecommendHeadView()
        return RecommendHeadView
    }()
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchController()
        let appItemCell = UINib(nibName: "appItemTableViewCell", bundle: nil)
        tableView.register(appItemCell, forCellReuseIdentifier: NSStringFromClass(appItemTableViewCell.self))
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [self] in
            if self.index == 100{
                tableView.mj_footer?.resetNoMoreData()
            }
            self.loadData(isReloadData: true)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.loadData(isReloadData: false)
        })
        getRealmDB() ? tableView.mj_header?.beginRefreshing() : nil
    }
}
extension HomeViewController{
    /// 初始化搜索控制器
    func initSearchController() {
        searchC = UISearchController.init(searchResultsController: nil)
        searchC.searchResultsUpdater = self
        //设置为false，则搜索出来的内容可点击等操作
        searchC.obscuresBackgroundDuringPresentation = false
        //总是显示搜索框,如果不设置，会随着滚动而消失
        navigationItem.hidesSearchBarWhenScrolling = false
        //将搜索控制器加到导航栏上
        navigationItem.searchController = searchC

    }
}
extension HomeViewController{
    func getRealmDB() -> Bool {
        let allRealms = realm.objects(entryCacheModel.self)
        if allRealms.count != 0 {
            var tempAllRealmsArray = [entryCacheModel]()
            for model in allRealms {
                tempAllRealmsArray.append(model)
            }
            topItemArry = tempAllRealmsArray
            allRealmsArray = tempAllRealmsArray
            self.index = self.topItemArry.count
            if self.topItemArry.count == 100 {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
            return self.topItemArry.count > 0 ? false :true
        }
        return true
    }
}
extension HomeViewController: UISearchResultsUpdating {
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        self.topItemArry = allRealmsArray!.filter { (entryCacheModel) -> Bool in
              if searchController.searchBar.text! == ""{
                  return true
                }
                return (entryCacheModel.itemTitle.contains(searchController.searchBar.text!) || entryCacheModel.summary.contains(searchController.searchBar.text!) || entryCacheModel.rights.contains(searchController.searchBar.text!))
            }
        }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }
        return 180
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return topItemArry.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return RecommendHeadView
        }
        return ItemHeadView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier:  NSStringFromClass(appItemTableViewCell.self), for: indexPath) as! appItemTableViewCell
            let model = topItemArry[indexPath.row]
            cell.setData(model: model, cell: cell, indexPath: indexPath)
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
    }
}

extension HomeViewController{
    func loadData(isReloadData:Bool){
        self.index = isReloadData ? 10 : self.index+10
        let limitStr = String(self.index) + "/json"
        ViewModel.shared.fetchTopfreeapplicationsData(limit:limitStr) { [self] (data) in
            isReloadData ? tableView.mj_header!.endRefreshing() : tableView.mj_footer!.endRefreshing()
            guard let tempArray = data else {
                return
            }
            let tempEntryArry = (tempArray as! topGrossingApplicationsModelArray).entry
            self.setEntryCacheModel(tempEntryArry:tempEntryArry!)
            if self.topItemArry.count == 100 {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
}

extension HomeViewController{
    func setEntryCacheModel(tempEntryArry:[entryModelArray]) -> Void {
        try! realm.write {
            realm.deleteAll()
        }
        var tempModelArry  = [entryCacheModel]()
        for i in 0..<tempEntryArry.count {
            let model = tempEntryArry[i]
            try! realm.write({
            let tempCacheModel = entryCacheModel()
                tempCacheModel.itemTitle = (model.title?.label)!
                tempCacheModel.itemCategory = (model.category?.attributes?.label)!
                tempCacheModel.itemImage = (model.image?.last?.label)!
                tempCacheModel.itemCount = i
                tempCacheModel.starViewScore = 0
                tempCacheModel.itemComments = ""
                tempCacheModel.summary = (model.summary?.label)!
                tempCacheModel.rights = model.rights?.label ?? ""
                tempCacheModel.itemId = (model.id?.attributes?.id)!
                tempCacheModel.updateBool = false
                realm.add(tempCacheModel,update: .error)
                tempModelArry.append(tempCacheModel)
            })
        }
        allRealmsArray = tempModelArry
        topItemArry = tempModelArry
    }
    
}
