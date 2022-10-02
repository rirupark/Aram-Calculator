//
//  IfLeaveFoodViewController.swift
//  AramCalculator
//
//  Created by 박민주 on 2022/09/29.
//

import UIKit

class IfLeaveFoodViewController: UIViewController {
    
    @IBOutlet weak var lbDataFromCalcVC: UILabel!
    @IBOutlet weak var lbAlternativeFood: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - IfLeaveFoodVC의 Label에 남은 식수를 세팅하는 함수
    // 기기에 저장된 남은 식수 데이터를 VC로 보내야 함.
    func setLabelLeftFoodCount(_ text: String) {
        lbDataFromCalcVC.text = text
    }
    
    
    // MARK: - IfLeaveFoodVC의 Label에 대체 음식 수를 세팅하는 함수
    func setLabelAlternativeFood(_ text: String) {
        lbAlternativeFood.text = text
    }

}


