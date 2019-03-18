//
//  Realm.swift
//  ExpenseWise
//
//  Created by Santiago Bustamante on 1/30/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import Realm
import RealmSwift

public extension Object {
    public func save() {
        do {
            let realm = try Realm()
            do {
                try realm.write({ () -> Void in
                    realm.add(self, update: true)
                })
            } catch {
                print("REALM: impossible update object - \(error)")
            }

        } catch {
            print("REALM: impossible get the realm default with error: \(error)")
        }
    }

    public func update<T: Object>(_ updates: @escaping (_ object: T) -> Void) {
        do {
            let realm = try Realm()

            do {
                try realm.write({ () -> Void in
                    updates(self as! T)
                })
            } catch {
                print("REALM: impossible update object - \(error)")
            }

        } catch {
            print("REALM: impossible get the realm default with error: \(error)")
        }
    }
}

public extension Realm {
    public class func update(_ updateClosure: @escaping (_ realm: Realm) -> Void) {
        do {
            let realm = try Realm()
            do {
                try realm.write({ () -> Void in
                    updateClosure(realm)
                })
            } catch {
                print("REALM: impossible update object - \(error)")
            }

        } catch {
            print("REALM: impossible get the realm default with error: \(error)")
        }
    }

    public class func query(_ queryClosure: @escaping (_ realm: Realm) -> Void) {
        do {
            let realm = try Realm()
            queryClosure(realm)

        } catch {
            print("REALM: impossible get the realm default with error: \(error)")
        }
    }
}
