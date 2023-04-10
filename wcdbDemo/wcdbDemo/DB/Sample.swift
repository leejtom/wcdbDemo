//
//  Sample.swift
//  wcdbDemo
//
//  Created by JTom on 2023/4/3.
//

import WCDBSwift

final class Sample: TableCodable {
    var identifier: Int = 0
    var description: String? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        
        case identifier
        case description
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(identifier, isPrimary: true) // 设为主键
            BindColumnConstraint(description, isNotNull: true, defaultTo: "defaultDescription")
        }
    }
    
    var isAutoIncrement: Bool {return true} // 用于定义是否使用自增的方式插入
    var lastInsertedRowID: Int64 = 0 // 用于获取自增插入后的主键值
}
