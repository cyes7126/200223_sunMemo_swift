//
//  ComposeViewController.swift
//  sunMemo
//
//  Created by 유은선 on 2020/02/23.
//  Copyright © 2020 Eun seon Yu. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet var memoTextView: UITextView!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)//모달을 닫을때는 dismiss
    }
    
    @IBAction func save(_ sender: Any) {
        let memo = memoTextView.text
        let newMemo = Memo(content: memo ?? "")
        Memo.dummyMemoList.append(newMemo)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
