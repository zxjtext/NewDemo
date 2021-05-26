//
//  Item.swift
//  NSOperation
//
//  Created by Stan on 2017-07-24.
//  Copyright © 2017 stan. All rights reserved.
//

import Foundation

class Item {
    let itemId: String
    init(number: String) {
        itemId = number
    }
   static func creatItems(CacheModelArray: [entryCacheModel]) -> [Item] {
    var items = [Item]()
    for model in CacheModelArray {
        items.append(Item(number: model.itemId))
        }
        return items
    }
    func imageUrl() -> URL? {
        return URL(string:"https://itunes.apple.com/hk/lookup?id=\(itemId)")
    }
}
