//
//  User.swift
//  realm-migration
//
//  Created by Daisuke Kubota on 2019/12/24.
//  Copyright © 2019 Daisuke Kubota. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
}
