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
    
    //토큰을 저장할 속성
    var willShowToken: NSObjectProtocol?
    var willHideToken: NSObjectProtocol?
    
    //뷰컨트롤러가 제거되는 시점에 옵져버도 해제됨.
    deinit {
        if let token = willShowToken{
            NotificationCenter.default.removeObserver(token)
        }
        if let token = willHideToken{
            NotificationCenter.default.removeObserver(token)
        }
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
        //옵져버 등록은 보통 viewDidLoad에서 함
        
        //키보드생기먄 여백 추가
        willShowToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            guard let strongSelf = self else { return }
            
            if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let height = frame.cgRectValue.height
                
                var inset = strongSelf.memoTextView.contentInset //현재 설정된 값
                inset.bottom = height
                strongSelf.memoTextView.contentInset = inset //bottom을 제외한 나머지 값은 유지됨
                
                //텍스트뷰 오른쪽 스크롤바에 같은 크기 여백 추가
                inset = strongSelf.memoTextView.scrollIndicatorInsets
                inset.bottom = height
                strongSelf.memoTextView.scrollIndicatorInsets = inset
            }
            
        })
        
        //키보드 사라질때 여백제거
        willHideToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in
            guard let strongSelf = self else { return }
            
            var inset = strongSelf.memoTextView.contentInset //현재 설정된 값
            inset.bottom = 0
            strongSelf.memoTextView.contentInset = inset //bottom을 제외한 나머지 값은 유지됨
            
            //텍스트뷰 오른쪽 스크롤바에 같은 크기 여백 추가
            inset = strongSelf.memoTextView.scrollIndicatorInsets
            inset.bottom = 0
            strongSelf.memoTextView.scrollIndicatorInsets = inset
        })
    }
    
    //화면을 탭하지 않고도, 화면 진입하면 바로 작성가능하도록 함
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memoTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //입력포커스 제거, 키보드 사라짐
        memoTextView.resignFirstResponder()
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
