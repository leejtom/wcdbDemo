//
//  ViewController.swift
//  wcdbDemo
//
//  Created by JTom on 2023/4/3.
//

import UIKit

enum DBTableName : String {
    case sampleTable = "Sample"
}

class ViewController: UIViewController {
    
    var db: WCDBOperator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建数据库
        db = WCDBOperator(basePath: WCDBBasePath.basePath)
        // 创建表
        self.createTable()
        
        let inserButton = UIButton.init(frame: CGRect(origin: CGPoint.init(x: 100, y: 100), size: CGSize.init(width: 100, height: 30)))
        inserButton.setTitle("inser", for: .normal)
        inserButton.setTitleColor(.black, for: .normal)
        inserButton.addTarget(self, action: #selector(inser), for: .touchUpInside)
        self.view.addSubview(inserButton)
        
        let deleteButton = UIButton.init(frame: CGRect(origin: CGPoint.init(x: 100, y: 140), size: CGSize.init(width: 100, height: 30)))
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        self.view.addSubview(deleteButton)
        
        let updateButton = UIButton.init(frame: CGRect(origin: CGPoint.init(x: 100, y: 180), size: CGSize.init(width: 100, height: 30)))
        updateButton.setTitle("update", for: .normal)
        updateButton.setTitleColor(.black, for: .normal)
        updateButton.addTarget(self, action: #selector(update), for: .touchUpInside)
        self.view.addSubview(updateButton)
        
        let queryButton = UIButton.init(frame: CGRect(origin: CGPoint.init(x: 100, y: 220), size: CGSize.init(width: 100, height: 30)))
        queryButton.setTitle("query", for: .normal)
        queryButton.setTitleColor(.black, for: .normal)
        queryButton.addTarget(self, action: #selector(query), for: .touchUpInside)
        self.view.addSubview(queryButton)
    }
    
    private func createTable() {
        print("---createTable----")
        db?.createTable(DBTableName.sampleTable.rawValue, type: Sample.self)
    }
    
    // 插入
    @objc private func inser() {
        print("---inser----")
        var milliStamp = Date().milliStamp
        let model = Sample()
        model.identifier = Int(milliStamp)!
        model.age = Int(milliStamp)!
        model.description = "inser \(milliStamp)"
        
        milliStamp = Date().milliStamp
        let model2 = Sample()
        model2.identifier = Int(milliStamp)!
        model2.age = Int(milliStamp)!
        model2.description = "inser\(milliStamp)"
        
        db?.inset(objects: [model, model2], tableName: DBTableName.sampleTable.rawValue)
    }
    
    // 修改
    @objc private func update() {
        print("---update----")
        let model1 = Sample.init()
        model1.description = "update\(Date().milliStamp)"
        db?.update(DBTableName.sampleTable.rawValue, on: [Sample.Properties.description], with: model1, where: Sample.Properties.identifier.intValue == 1681308965225)
    }
    
    // 查找
    @objc private func query() {
        print("---query----")
        let dataArray:[Sample] = db?.query(DBTableName.sampleTable.rawValue) ?? [Sample()]
        dataArray.forEach({ (data) in
            print(data.identifier, data.description ?? "", data.age)
        })
    }
    
    // 删除
    @objc private func deleteAction() {
        print("---delete----")
        db?.delete(DBTableName.sampleTable.rawValue)
    }
    
    
}


extension Date {

  /// 获取当前 秒级 时间戳 - 10位
  var timeStamp : String {
    let timeInterval: TimeInterval = self.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return "\(timeStamp)"
  }

  /// 获取当前 毫秒级 时间戳 - 13位
  var milliStamp : String {
    let timeInterval: TimeInterval = self.timeIntervalSince1970
    let millisecond = CLongLong(round(timeInterval*1000))
    return "\(millisecond)"
  }
}

