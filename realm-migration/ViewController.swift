//
//  ViewController.swift
//  realm-migration
//
//  Created by Daisuke Kubota on 2019/12/24.
//  Copyright © 2019 Daisuke Kubota. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        migrate()
    }

}


extension ViewController {
    func migrate() {
        let version: UInt64 = 0
        do {
            let configuration = Realm.Configuration(schemaVersion: version,
                                                    migrationBlock: { migration, oldVersion in
                                                        debugPrint("oldVersion: \(oldVersion), version: \(version)")
                                                        debugPrint("newScheme: \(migration.newSchema)")
                                                    })
            Realm.Configuration.defaultConfiguration = configuration
            _ = try Realm()
        } catch let error {
            debugPrint(error)
        }
    }
}
