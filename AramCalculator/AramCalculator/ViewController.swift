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
    @IBOutlet weak var tf_input: UITextField!
    @IBOutlet weak var lb_result: UILabel!
    @IBAction func btn_calculate(_ sender: Any) {
        guard let input = Int(tf_input.text ?? "") else { return }
        let output = getNumToEatAram(input)
        lb_result.text = output
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNumKeyBoard()
    }
    
    
    // MARK: - 먹어야 하는 식수를 구하는 함수
    /// 먹어야 하는 식수를 구하는 함수
    func getNumToEatAram(_ input:Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let today = dateFormatter.date(from: getNowDate()) ?? Date()
        let endday = dateFormatter.date(from: "2022-12-21") ?? Date() // 아람 종료일(12/21) 당일은 아침만 배식함.

        let interval = endday.timeIntervalSince(today)
        let dday = Int(interval / 86400)
        
        print("남은 일수 :", dday)
        print("아람 배식하는 식수 :", dday * 3 - 2)

        let result = Double(input) / Double(dday)
        
        return result <= 3.0 ? "매일 \(String(format: "%.2f", result))끼씩 먹으면 다 먹을 수 있어요 !" : "매일 3끼씩 먹어도 \(input - (dday * 3 - 2))식이 남아요 !"
    }

    
    // MARK: - 현재 날짜를 구하는 함수
    /// 현재 날짜를 구하는 함수
    func getNowDate() -> String {
        let nowDate = Date() // 현재의 Date 날짜 및 시간
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        dateFormatter.dateFormat = "yyyy-MM-dd" // Date 포맷 타입 지정
        
        let date = dateFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환

        print("현재 날짜 :", date)
        return date
    }


    // MARK: - 숫자 키보드 설정 함수
    /// 숫자 키보드 설정 함수
    func setNumKeyBoard() {
        tf_input.keyboardType = .numberPad
    }
}
