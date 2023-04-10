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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        
        //        var dataArray =  query()
        //        dataArray?.forEach({ (data) in
        //            print(data.identifier, data.description ?? "")
        //        })
        //
        //        inser()
        //
        //        dataArray =  query()
        //        dataArray?.forEach({ (data) in
        //            print(data.identifier, data.description ?? "")
        //        })
        //
        //        update()
        //
        //        dataArray =  query()
        //        dataArray?.forEach({ (data) in
        //            print(data.identifier, data.description ?? "")
        //        })
        
        //        delete()
        //
        //        dataArray =  query()
        //        dataArray?.forEach({ (data) in
        //            print(data.identifier, data.description ?? "")
        //        })
    }
    
    private func createTable() {
        print("---createTable----")
        WCDBOperator.share.createTable(DBTableName.sampleTable.rawValue, type: Sample.self)
    }
    
    // 插入
    @objc private func inser() {
        print("---inser----")
        let model1 = Sample()
        model1.description = "inser \(Date.timeIntervalBetween1970AndReferenceDate)"
        
        WCDBOperator.share.inset(objects: [model1], tableName: DBTableName.sampleTable.rawValue)
    }
    
    // 修改
    @objc private func update() {
        print("---update----")
        let model1 = Sample.init()
        model1.description = "1update \(Date.timeIntervalBetween1970AndReferenceDate)"
        WCDBOperator.share.update(DBTableName.sampleTable.rawValue, on: [Sample.Properties.description], with: model1)
    }
    
    // 查找
    @objc private func query() {
        print("---query----")
        let dataArray:[Sample] = WCDBOperator.share.query(DBTableName.sampleTable.rawValue) ?? [Sample()]
        dataArray.forEach({ (data) in
            print(data.identifier, data.description ?? "", data.lastInsertedRowID)
        })
    }
    
    // 删除
    @objc private func deleteAction() {
        print("---delete----")
        WCDBOperator.share.delete(DBTableName.sampleTable.rawValue)
    }
    
    
}


