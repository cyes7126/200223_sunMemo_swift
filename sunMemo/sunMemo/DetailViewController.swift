//
//  DetailViewController.swift
//  sunMemo
//
//  Created by 유은선 on 2020/02/24.
//  Copyright © 2020 Eun seon Yu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long //long:20년2월23일, medium:2020.02.23
        f.timeStyle = .medium
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    var memo: Memo?//최초로 선언될땐 값이 없으므로 옵셔널로 선언
    
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

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //테이블뷰가 어떤 디자인, 어떤 내용을 표시할지
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            cell.textLabel?.text = memo?.content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            return cell
        default :
            fatalError()
                
        }
    }
    
    
}
