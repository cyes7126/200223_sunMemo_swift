//
//  MemoListTableViewController.swift
//  sunMemo
//
//  Created by 유은선 on 2020/02/23.
//  Copyright © 2020 Eun seon Yu. All rights reserved.
//

import UIKit

class MemoListTableViewController: UITableViewController {
    
    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long //long:20년2월23일, medium:2020.02.23
        f.timeStyle = .none
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    //뷰가 화면에 표시하기 직전에 실행 : 테이블뷰에 목록을 업데이트하라고 명령
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    //필수메서드.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Memo.dummyMemoList.count //더미데이터 숫자 리턴(몇개를 출력해야 하는지)
    }

    //필수메서드.하나의 셀을 화면에 표시할때 마다 반복적으로 호출함
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //"cell"이라는 셀을 가져옴
        
        let target = Memo.dummyMemoList[indexPath.row] //row속성을 활용해 테이블에서 몇번째값인지 확인
        cell.textLabel?.text = target.content
        //cell.detailTextLabel?.text = "\(target.insertDate)" //00:00:00 +0000
        cell.detailTextLabel?.text = formatter.string(from: target.insertDate)
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
