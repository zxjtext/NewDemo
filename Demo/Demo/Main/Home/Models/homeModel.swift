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
    @objc dynamic var starViewScore  = 0.0
    @objc dynamic var itemComments  = ""
    @objc dynamic var summary  = ""
    @objc dynamic var rights  = ""
    @objc dynamic var itemId  = ""
    @objc dynamic var updateBool  = false
    override class func primaryKey() -> String? {
            return "itemCount"
    }
    
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
    var  summary : entrySummaryAttributesModel?
    var  rights : entryRightsAttributesModel?
    var  id : AttributesIdItemModel?
    
}
class entryRightsAttributesModel:BaseModel{
    var label : String?
}
class entrySummaryAttributesModel:BaseModel{
    var label : String?
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
}

class AttributesIdItemModel:BaseModel{
    var attributes : idAttributesItemModel?
}
class idAttributesItemModel:BaseModel{
    var id : String?
    var bundleId : String?
}
//lookUp
class lookUpSuperModelArray :BaseModel{
    var resultCount : String?
    var results : [lookUpModelArray]?
}
class lookUpModelArray :BaseModel{
    var averageUserRating : Double = 0.0
    var description : String?
    var userRatingCount : String?
}

