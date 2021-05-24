//
//  testResponse.swift
//  EY.Mtel_ProjectTemplate_Swift
//
//  Created by zxj on 2020/8/10.
//  Copyright © 2020 EY.Mtel. All rights reserved.
//

import UIKit
import HandyJSON
import RealmSwift

class entryCacheModel: Object{
    
    @objc dynamic var itemTitle = ""
    @objc dynamic var itemCategory = ""
    @objc dynamic var itemImage = ""
    @objc dynamic var itemCount = 0
    @objc dynamic var starViewScore  = 0
    @objc dynamic var itemComments  = ""
    
}

class topGrossingApplicationsModelArray :BaseModel{
    var author: authorModelArray?
    var entry:  [entryModelArray]?
    var updated:Any?
    var rights:Any?
    var title:Any?
    var icon:Any?
    var link:Any?
    var id:Any?
}
class authorModelArray:BaseModel{
    var name: entryModelTitle?
    var uri: entryModelTitle?
}
class entryModelArray:BaseModel{
    var  image : [entryModelImage]?
    var  name : entryNameModelTitle?
    var  title : entryModelTitle?
    var  category : entryCategoryAttributesModel?
}
class entryNameModelTitle:BaseModel{
    var label : String?
}
class entryModelTitle:BaseModel{
    var label : String?
}
class entryModelImage:BaseModel{
    var label : String?
    var attributes : Any?
}
class entryCategoryAttributesModel:BaseModel{
    var attributes : entryCategoryAttributesItemModel?
}
class entryCategoryAttributesItemModel:BaseModel{
    var label : String?
    var id : String?
}

