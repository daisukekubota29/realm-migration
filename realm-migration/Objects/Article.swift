//
//  Article.swift
//  realm-migration
//
//  Created by Daisuke Kubota on 2019/12/24.
//  Copyright © 2019 Daisuke Kubota. All rights reserved.
//

import Foundation
import RealmSwift

class Article: Object {
    /// ID
    @objc dynamic var id: String = ""
    /// Owner
    @objc dynamic var owner: User?
    /// Categories
    let categories = List<Category>()
    /// Title
    @objc dynamic var title: String = ""
    /// Body
    @objc dynamic var body: String = ""
}
