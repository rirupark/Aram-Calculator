//
//  ViewController.swift
//  AramCalculator
//
//  Created by 박민주 on 2022/09/12.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // MARK: - Properties
    public static var resultDataFromVC: Int = 0
    
    @IBOutlet weak var view_calculate: UIView!
    @IBOutlet weak var view_left: UIView!
    
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            view_calculate.alpha = 1.0
            view_left.alpha = 0.0
            print("fisrt view")
        } else {
            view_calculate.alpha = 0.0
            view_left.alpha = 1.0
            setData()
            print("second view")
        }
    }
    

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRounded()
    }

    
    // MARK: - UIView 테두리 둥글게
    func makeRounded() {
        view_calculate.layer.cornerRadius = 15
        view_calculate.layer.masksToBounds = true
        
        view_left.layer.cornerRadius = 15
        view_left.layer.masksToBounds = true
    }

    
    // MARK: - 기기에 저장된 남은 식수 데이터를 불러와서 IfLeaveFoodVC의 Label에 세팅시키는 함수
    func setData() {
        // 자식 뷰컨 불러오기
        let ILFVC = children.first as! IfLeaveFoodViewController
        ILFVC.setLabel(String(UserDefaults.standard.integer(forKey: "leftFood")))
    }
    
}

