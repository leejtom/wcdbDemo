//
//  WCDBOperator.swift
//  wcdbDemo
//
//  Created by lijingtong on 2023/4/10.
//

import Foundation
import WCDBSwift

public struct WCDBBasePath {
    static let basePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/DB/WCDB.db"
}

class WCDBOperator: NSObject {
    var dataBasePath: String
    var db: Database?
    
    public init(basePath: String) {
        self.dataBasePath = basePath
        super.init()
        db = self.createDB(path: basePath)
    }
    
    /// 创建数据库
    private func createDB(path: String) -> Database {
        return Database(at: path)
    }
    
    /// 创建表
    func createTable<T: TableDecodable>(_ tableName: String, type: T.Type) {
        do {
            try db?.run(transaction: {_ in
                try self.db?.create(table: tableName, of: type) 
            })
        } catch let error {
            debugPrint("create table error \(error.localizedDescription)")
        }
    }
    
    /// 插入数据
    func inset<T: TableEncodable>(objects: [T], tableName: String) {
        do {
            try db?.insert(objects, intoTable: tableName)
        } catch let error {
            debugPrint("insert objects error \(error.localizedDescription)")
        }
    }
    
    /// 更新数据
    func update<T: TableEncodable>(_ table: String,
                                   on propertyConvertibleList: [PropertyConvertible],
                                   with object: T,
                                   where condition: Condition? = nil,
                                   orderBy orderList: [OrderBy]? = nil,
                                   limit: Limit? = nil,
                                   offset: Offset? = nil) {
        do {
            try db?.update(table: table,
                           on: propertyConvertibleList,
                           with: object,
                           where: condition,
                           orderBy: orderList,
                           limit: limit,
                           offset: offset)
        } catch let error {
            debugPrint("update object error \(error.localizedDescription)")
        }
    }
    
    /// 删除数据
    func delete(_ tableName: String,
                where condition: Condition? = nil,
                orderBy orderList: [OrderBy]? = nil,
                limit: Limit? = nil,
                offset: Offset? = nil) {
        do {
            try db?.delete(fromTable: tableName, where: condition, orderBy: orderList, limit: limit, offset: offset)
        } catch let error {
            debugPrint("delete error \(error.localizedDescription)")
        }
    }
    
    /// 查询数据
    func query<T: TableDecodable>(_ tableName: String,
                                  where condition: Condition? = nil,
                                  orderBy orderList:[OrderBy]? = nil,
                                  limit: Limit? = nil,
                                  offset: Offset? = nil) -> [T]? {
        do {
            let allObjects: [T] = try (db?.getObjects(fromTable: tableName, where: condition, orderBy: orderList, limit: limit, offset: offset))!
            return allObjects
        } catch let error {
            debugPrint("query error \(error.localizedDescription)")
        }
        return nil
    }
    
    /// 删除表
    /// - Parameter tableName: 表名称
    func dropTable(_ tableName: String) {
        do {
            try db?.drop(table: tableName)
        } catch let error {
            debugPrint("drop table error \(error.localizedDescription)")
        }
    }
    
    /// 关闭并移除数据库所有数据
    func removeDBFile() {
        do {
            try db?.close(onClosed: {
                try self.db?.removeFiles()
            })
        } catch let error {
            debugPrint("remove DB File Error \(error.localizedDescription)")
        }
    }
}
