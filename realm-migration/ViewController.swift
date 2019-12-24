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
        let minimumVersion: UInt64 = 2
        let version: UInt64 = 2
        do {
            let configuration = Realm.Configuration(schemaVersion: version,
                                                    migrationBlock: { migration, oldVersion in
                                                        debugPrint("oldVersion: \(oldVersion), version: \(version)")
                                                        if oldVersion < minimumVersion {
                                                            self.deleteOldSchemas(migration: migration)
                                                            return
                                                        }
                                                    })
            Realm.Configuration.defaultConfiguration = configuration
            _ = try Realm()
        } catch let error {
            debugPrint(error)
        }
    }

    private func deleteOldSchemas(migration: Migration) {
        migration.oldSchema
            .objectSchema
            .map { $0.className }
            .filter { !$0.starts(with: "__") }
            .forEach { migration.deleteData(forType: $0) }
    }

    private func deleteUnknownObject(migration: Migration) {
        let objectNames = migration.newSchema.objectSchema.map { $0.className }
        let deletedObjectNames = migration.oldSchema
            .objectSchema
            .filter { !objectNames.contains($0.className) && !$0.className.starts(with: "__") }
            .map { $0.className }
        debugPrint("objectNames: \(objectNames)")
        debugPrint("deletedObjectNames: \(deletedObjectNames)")
        deletedObjectNames.forEach { migration.deleteData(forType: $0) }
    }
}
