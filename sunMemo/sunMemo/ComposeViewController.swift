//
//  ComposeViewController.swift
//  sunMemo
//
//  Created by 유은선 on 2020/02/23.
//  Copyright © 2020 Eun seon Yu. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var editTarget: Memo?
    
    @IBOutlet var memoTextView: UITextView!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)//모달을 닫을때는 dismiss
    }
    
    @IBAction func save(_ sender: Any) {
        let memo = memoTextView.text
        if let editTarget = editTarget{
            editTarget.content = memo //편집모드일땐 새로운 메모로 변경
            DataManager.shared.saveContext()
        }else{
            DataManager.shared.addNewMemo(memo)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let memo = editTarget{
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
        }else{
            navigationItem.title = "새 메모"
            memoTextView.text = ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
