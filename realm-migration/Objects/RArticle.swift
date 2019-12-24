//
//  RArticle.swift
//  realm-migration
//
//  Created by Daisuke Kubota on 2019/12/24.
//  Copyright © 2019 Daisuke Kubota. All rights reserved.
//

import Foundation
import RealmSwift

class RArticle: Object {
    /// ID
    @objc dynamic var id: String = ""
    /// Owner
    @objc dynamic var owner: RUser?
    /// Categories
    let categories = List<RCategory>()
    /// Title
    @objc dynamic var title: String = ""
    /// Body
    @objc dynamic var body: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}
