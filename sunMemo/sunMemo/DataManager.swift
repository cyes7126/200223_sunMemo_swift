//
//  DataManager.swift
//  sunMemo
//
//  Created by 유은선 on 2020/02/25.
//  Copyright © 2020 Eun seon Yu. All rights reserved.
//

import Foundation
import CoreData

class DataManager { //싱글톤으로 구현
    static let shared = DataManager()
    private init() {}
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var memoList = [Memo]()
    func fetchMemo(){
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        //내림차순 정렬
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        //fetchResquest 실행
        do{
            memoList = try mainContext.fetch(request) //예외가 발생하는 메서드(fetch)는 반드시 try와 함께 사용해야함
        }catch{
            print(error)
        }
    }
    
    func addNewMemo(_ memo : String?) {
        let newMemo = Memo(context: mainContext)
        newMemo.content = memo
        newMemo.insertDate = Date()
        
        saveContext()
    }
    
    func deleteMemo(_ memo : Memo?) {
        if let memo = memo {//실제로 메모가 전달된 경우에만 삭제
            mainContext.delete(memo)//임시로 삭제 (db아님)
            saveContext() //이렇게 해야 db까지 삭제
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "sunMemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
