//
//  RCategory.swift
//  realm-migration
//
//  Created by Daisuke Kubota on 2019/12/24.
//  Copyright © 2019 Daisuke Kubota. All rights reserved.
//

import Foundation
import RealmSwift

class RCategory: Object {
    /// ID
    @objc dynamic var id: String =  ""
    /// Name
    @objc dynamic var name: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}
