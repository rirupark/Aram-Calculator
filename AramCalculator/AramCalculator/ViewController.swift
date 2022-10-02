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
            print("second view")
            setDataLeftFoodCount()
            setDataAlternativeFood()
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
    func setDataLeftFoodCount() {
        // 자식 뷰컨 불러오기
        let ILFVC = children.first as! IfLeaveFoodViewController
        ILFVC.setLabelLeftFoodCount(String(UserDefaults.standard.integer(forKey: "leftFood") * 3600) + "원이 낭비돼요.")
    }
    
    
    // MARK: - 대체 음식과 낭비되는 가격을 IfLeaveFoodVC의 Label에 세팅시키는 함수
    func setDataAlternativeFood() {
        // 자식 뷰컨 불러오기
        let ILFVC = children.first as! IfLeaveFoodViewController
        // 기기에 저장된 남은 식수 불러오기
        let leftFoodCnt = UserDefaults.standard.integer(forKey: "leftFood")
        // 변수 선언
        let leftFoodPrice = leftFoodCnt * 3600
        var textAlternativeFood = "" // 최종 출력 텍스트
        // 가격 비교
        if leftFoodPrice < 3600 { textAlternativeFood = "낭비되는 돈이 없어요 :)" }
        else if leftFoodPrice < 6000 { textAlternativeFood = "커피 1잔을 마실 수 있어요." }
        else if leftFoodPrice < 20000 { textAlternativeFood = "국밥 \(leftFoodPrice / 6000)그릇을 먹을 수 있어요." }
        else { textAlternativeFood = "치킨 \(leftFoodPrice / 20000)마리를 먹을 수 있어요." }
        // setText
        ILFVC.setLabelAlternativeFood(textAlternativeFood)
    }
    
}

