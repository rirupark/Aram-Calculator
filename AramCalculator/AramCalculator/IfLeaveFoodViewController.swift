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
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 기기에 저장된 남은 식수 데이터를 VC로 보내기
    
    // MARK: - IfLeaveFoodVC의 Label에 남은 식수를 세팅하는 함수
    func setLabel(_ text: String) {
        lbDataFromCalcVC!.text = text
    }
    

}


