//
//  DAO.swift
//  Common
//
//  Created by Ezreal on 2019/11/6.
//  Copyright © 2019 bailun. All rights reserved.
//  轻量数据库实现

import YTKKeyValueStore
import HandyJSON

// MARK: - 一个Dao对应一张表，继承并指定模型即可使用

open class DAO<T: HandyJSON> {
    
    public final let store: YTKKeyValueStore
    
    /// 子类提供具体的表名
    private var tbName: String {
        didSet {
            store.createTable(withName: tbName)
        }
    }
    
    public required init() {
        store = YTKKeyValueStore(dbWithName: "com.ez.dao_demo.db")
        tbName = String(describing: type(of: self))
        
        /// 触发 didSet 自动建表
        defer { tbName = String(describing: type(of: self)) }
    }
}

// MARK: - 外部数据操作

public extension DAO {
    
    /// 保存一个对象
    func saveObject(_ object: T, key: String)  {
        if let jsonStr = object.toJSONString() {
            store.put(jsonStr, withId: key, intoTable: tbName)
        }
        
    }
    
    /// 保存对象数组
    func saveObjects(_ objects: [T], key: String)  {
        if let jsonStr = objects.toJSONString() {
            store.put(jsonStr, withId: key, intoTable: tbName)
        }
    }
    
    /// 查询单个对象
    func queryObject(key: String) -> T? {
        if let jsonStr = store.getStringById(key, fromTable: tbName) {
            return T.deserialize(from: jsonStr)
        }
        return nil
    }
    
    /// 查询对象数组
    func queryObjects(key: String) -> [T] {
        if let jsonStr = store.getStringById(key, fromTable: tbName) {
            return ([T].deserialize(from: jsonStr) as? [T]) ?? [T]()
        }
        return [T]()
    }
    
    /// 获取表中所有对象
    func getAllObjects() -> [T] {
        if let items = store.getAllItems(fromTable: tbName) {
            var objects = [T]()
            for item in items {
                if item is YTKKeyValueItem {
                    let item = item as! YTKKeyValueItem
                    if let itemObject = item.itemObject, itemObject is NSArray {
                        let itemObject = itemObject as! NSArray
                        if let object = itemObject.firstObject, object is String {
                            objects.append(T.deserialize(from: object as? String) ?? T())
                        }
                    }
                }
            }
            return objects
        }
        return [T]()
    }
    
    /// 删除指定存储数据
    func delete(key: String) {
        store.deleteObject(byId: key, fromTable: tbName)
    }
    
    /// 清除数据表
    func clear() {
        store.clearTable(tbName)
    }
}
