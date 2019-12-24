//
//  ViewController.swift
//  realm-migration
//
//  Created by Daisuke Kubota on 2019/12/24.
//  Copyright © 2019 Daisuke Kubota. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        migrate().subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                debugPrint("result: \(result)")
            }, onError: { error in
                debugPrint(error)
            }, onCompleted: {
                debugPrint("completed")
            }, onDisposed: nil)
            .disposed(by: disposeBag)
    }

}

extension ViewController {
    func migrate() -> Observable<Bool> {
        return Observable.create { observer -> Disposable in
            let minimumVersion: UInt64 = 2
            let version: UInt64 = 3
            let configuration = Realm.Configuration(schemaVersion: version,
                                                    migrationBlock: { migration, oldVersion in
                                                        debugPrint("Thread.isMainThread: \(Thread.isMainThread)")
                                                        debugPrint("oldVersion: \(oldVersion), version: \(version)")
                                                        observer.on(.next(true))
                                                        if oldVersion < minimumVersion {
                                                            self.deleteOldSchemas(migration: migration)
                                                            return
                                                        }
                                                    })
            Realm.Configuration.defaultConfiguration = configuration
            Realm.asyncOpen { _, error in
                guard let error = error else {
                    debugPrint("migration success!")
                    observer.on(.completed)
                    return
                }
                debugPrint(error)
                observer.on(.error(error))
            }
            return Disposables.create()
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
