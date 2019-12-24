//
//  RUser.swift
//  realm-migration
//
//  Created by Daisuke Kubota on 2019/12/24.
//  Copyright © 2019 Daisuke Kubota. All rights reserved.
//

import Foundation
import RealmSwift

<<<<<<< HEAD:realm-migration/Objects/RUser.swift
class RUser: Object {
=======
class User: Object {
    /// ID
>>>>>>> v1:realm-migration/Objects/User.swift
    @objc dynamic var id: String = ""
    /// Name
    @objc dynamic var name: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}
