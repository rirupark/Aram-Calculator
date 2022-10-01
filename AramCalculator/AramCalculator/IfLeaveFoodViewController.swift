//
//  IfLeaveFoodViewController.swift
//  AramCalculator
//
//  Created by 박민주 on 2022/09/29.
//

import UIKit
import CoreData

class IfLeaveFoodViewController: UIViewController {
    
    @IBOutlet weak var lbDataFromCalcVC: UILabel?
    
//    var completionRefer: () -> Void = {
//        lbDataFromCalcVC!.text = String(UserDefaults.standard.integer(forKey: "leftFood"))
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getData())
        lbDataFromCalcVC!.text = String(UserDefaults.standard.integer(forKey: "leftFood"))
        

    }
    
    
    // MARK: - 기기에 저장된 남은 식수 데이터 불러오는 함수
    func getData() -> Int {
        return UserDefaults.standard.integer(forKey: "leftFood")
    }
    
}


