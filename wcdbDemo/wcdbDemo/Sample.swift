//
//  Sample.swift
//  wcdbDemo
//
//  Created by JTom on 2023/4/3.
//

import Foundation
import WCDBSwift

class Sample: TableCodable {
    var identifier: Int? = nil;
    var description: String? = nil;
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case description
    }
}

extension Sample {
    func createDatabase() {
        let database = Database(at: "~/Intermediate/Directories/Will/Be/Created/sample.db")
        database.create(table: "sampleTable", of: Sample.self)
        
    }
}
