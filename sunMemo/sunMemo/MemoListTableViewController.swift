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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //세그웨이가 연결된 화면을 생성하고, 생성된 화면을 전환하기전 자동으로 호출됨
        //sender : 세그웨이를 선택한 셀 -> sender를 활용해 몇번째 셀이 연결됐는지 계산함
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            let target = DataManager.shared.memoList[indexPath.row]
            
            if let vc = segue.destination as? DetailViewController {
                vc.memo = target
            }
        }
    }
    
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
        DataManager.shared.fetchMemo()
        tableView.reloadData()
    }
    
    //필수메서드.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.memoList.count
    }
    
    //필수메서드.하나의 셀을 화면에 표시할때 마다 반복적으로 호출함
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //"cell"이라는 셀을 가져옴
        
        let target = DataManager.shared.memoList[indexPath.row] //row속성을 활용해 테이블에서 몇번째값인지 확인
        cell.textLabel?.text = target.content
        //cell.detailTextLabel?.text = "\(target.insertDate)" //00:00:00 +0000
        cell.detailTextLabel?.text = formatter.string(for: target.insertDate)
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let target = DataManager.shared.memoList[indexPath.row]
            DataManager.shared.deleteMemo(target)
            //배열에서도 메모 삭제 (안하면  crash)
            DataManager.shared.memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
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
