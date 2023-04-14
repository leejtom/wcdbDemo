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
    var age: Int = 0
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        
        case identifier
        case description
        case age
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
    }
    
    public init() {}
}
