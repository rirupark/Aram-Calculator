//
//  CalculateViewController.swift
//  AramCalculator
//
//  Created by 박민주 on 2022/09/27.
//

import UIKit
import CoreData

struct LeftFoodCount {
    public static var data: Int = 0
}

class CalculateViewController: UIViewController {
    
    // MARK: - Properties
    var resultData : Int = 0

    @IBOutlet weak var tf_input: UITextField!
    @IBOutlet weak var lb_result: UILabel!
    
    let container = NSPersistentContainer(name: "DataModel")
    
    @IBAction func btn_calculate(_ sender: Any) {
        guard let input = Int(tf_input.text ?? "") else { return }
        let output = getNumToEatAram(input)
        lb_result.text = output
        
        // 기기에 식수 데이터 저장하기 - 계산하기 버튼 클릭 시 저장됨.
        UserDefaults.standard.set(String(input), forKey: "key")
        
        // 기기에 남은 식수 데이터 저장
        UserDefaults.standard.set(resultData, forKey: "leftFood")
     
    }
    
    @IBAction func btn_plus(_ sender: Any) {
        guard let input = Int(tf_input.text ?? "") else { return }
        tf_input.text = String(input + 1)
    }
    
    @IBAction func btn_minus(_ sender: Any) {
        guard let input = Int(tf_input.text ?? "") else { return }
        tf_input.text = String(input - 1)
    }

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
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
        
        // 남은 식수의 비용으로 대체 음식을 계산하기 위한 남은 식수 데이터
        resultData = input - (dday * 3 - 2) > 0 ? input - (dday * 3 - 2) : 0
        
        return result <= 3.0 ? "매일 \(String(format: "%.2f", result))끼씩 먹으면 다 먹을 수 있어요 :)" : "매일 3끼씩 먹어도 \(input - (dday * 3 - 2))식이 남아요 :("
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
    
    
    // MARK: - 기기에 저장된 식수 데이터 불러오는 함수
    func getData() {
        tf_input.text = UserDefaults.standard.string(forKey: "key")
    }
    
    
    // MARK: - 결과 텍스트 커스텀 함수
    func textCustom() {
        // Something custom code...
    }


}
