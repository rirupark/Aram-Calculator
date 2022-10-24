//
//  CalculateViewController.swift
//  AramCalculator
//
//  Created by 박민주 on 2022/09/27.
//

import UIKit

class CalculateViewController: UIViewController {
    
    // MARK: - Properties
    var resultData : Int = 0

    @IBOutlet weak var tf_input: UITextField!
    @IBOutlet weak var lb_result: UILabel!
    
    @IBAction func btn_calculate(_ sender: Any) {
        guard let input = Int(tf_input.text ?? "") else { return }
        let output = getNumToEatAram(input)
        lb_result.text = output
        
        // 기기에 식수 데이터 저장하기 - 계산하기 버튼 클릭 시 저장됨.
        UserDefaults.standard.set(String(input), forKey: "food")
        
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
        // 날짜 차이 구하기 - 남은 일수를 구하기 위함
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // 계산일과 종료일
        let today = dateFormatter.date(from: getNowDate()) ?? Date()
        let endday = dateFormatter.date(from: "2022-12-21") ?? Date() // 아람 종료일(12/21) 당일은 아침만 배식함.
        print("today : \(today)")

        let intervalDay = endday.timeIntervalSince(today)
        let dday = Int(intervalDay / 86400) // 당일을 제외한 남은 일수
        var servingCount = dday * 3 - 2 // 아람 배식하는 식수
        print("남은 일수 :", dday)
        
        // 시간 차이 구하기 - 계산하는 시각에 따라 남은 아람 배식 식수가 달라지기 때문
        // 당일 정각부터 계산하는 시각까지의 차이가 각각 조식, 중식, 석식 배식 시간보다 크면 배식 시간을 놓친 것.
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let startTime = dateFormatter.date(from: getNowDate() + " 00:00") ?? Date()
        let endTime = dateFormatter.date(from: getNowTime()) ?? Date()

        let intervalTime = Int(endTime.timeIntervalSince(startTime))
        let timer = Int(intervalTime / 60)
        print("nowTime : \(startTime)")
        print("오늘 자정부터 현재까지의 시간차 : \(timer)분")
        
        // 오늘 날짜의 요일별로 배식 마감 시간 구분하기
        // timer가 각 시간보다 작을 때만 아람 배식 식수에 포함시키기
        // - 조식, 중식, 석식 마감 시간 변수 초기화 - 평일과 주말에 따라 다르기 때문에 switch문 밖에 선언
        var endBreakFastTime: Date = Date()
        var endLunchTime: Date = Date()
        var endDinnerTime: Date = Date()
        // - 조식, 중식 ,석식 시간 차이
        var intervalBreakFastTime: Int = 0
        var intervalLunchTime: Int = 0
        var intervalDinnerTime: Int = 0
        // - 시간 차이 분 단위로 환산
        var timerBreakFast: Int = 0
        var timerLunch: Int = 0
        var timerDinner: Int = 0

        switch getNowDayOfTheWeek() {
        case "월", "화", "수", "목", "금":
            print("오늘은 평일입니다.")
            endBreakFastTime = dateFormatter.date(from: getNowDate() + " 09:30") ?? Date()
            endLunchTime = dateFormatter.date(from: getNowDate() + " 13:30") ?? Date()
            endDinnerTime = dateFormatter.date(from: getNowDate() + " 19:00") ?? Date()
            
        default:
            print("오늘은 주말입니다.")
            endBreakFastTime = dateFormatter.date(from: getNowDate() + " 09:00") ?? Date()
            endLunchTime = dateFormatter.date(from: getNowDate() + " 13:30") ?? Date()
            endDinnerTime = dateFormatter.date(from: getNowDate() + " 18:40") ?? Date()
        }
        
        intervalBreakFastTime = Int(endBreakFastTime.timeIntervalSince(startTime))
        intervalLunchTime = Int(endLunchTime.timeIntervalSince(startTime))
        intervalDinnerTime = Int(endDinnerTime.timeIntervalSince(startTime))
        
        timerBreakFast = Int(intervalBreakFastTime / 60)
        timerLunch = Int(intervalLunchTime / 60)
        timerDinner = Int(intervalDinnerTime / 60)
        
        // 시간대별 배식 식수를 통해 아람 배식 식수(servingCount)에 추가해준다. (+1, +2, +3)
        if timer < timerBreakFast { servingCount += 3 }
        else if timer > timerBreakFast && timer < timerLunch { servingCount += 2 }
        else if timer > timerLunch && timer < timerDinner { servingCount += 1 }
        // else { 당일은 이미 석식 시간을 지남. }
        print("아람 배식하는 식수 :", servingCount)

        // 매일 먹어야 하는 식수
        let result = Double(input) / Double(dday)
        print("매일 먹어야 하는 식수 :", result)
        
        // 남은 식수의 비용으로 대체 음식을 계산하기 위한 남은 식수 데이터
        resultData = input - servingCount > 0 ? input - servingCount : 0
        print("남은 식수 :", resultData)
        
        // 남은 식수가 아람관에서 배식하는 식수보다 적어야 하고, result값이 3보다 같거나 작아야 다 먹을 수 있음.
        return result <= 3.0 && servingCount >= input ? "매일 \(String(format: "%.2f", result))끼씩 먹으면 다 먹을 수 있어요 :)" : "매일 3끼씩 먹어도 \(input - servingCount)식이 남아요 :("
    }

    
    // MARK: - 현재 날짜와 시각을 구하는 함수
    func getNowTime() -> String {
        let nowDate = Date() // 현재의 Date 날짜 및 시간
        let timeFormatter = DateFormatter() // Date 포맷 객체 선언
        
        timeFormatter.locale = Locale(identifier: "ko") // 한국 지정
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm" // Date 포맷 타입 지정
        
        let date = timeFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환
       
        print("현재 날짜와 시각 :", date)
        return date
    }
    
    
    // MARK: - 현재 날짜를 구하는 함수
    func getNowDate() ->String {
        let nowDate = Date() // 현재의 Date 날짜 및 시간
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        dateFormatter.dateFormat = "yyyy-MM-dd" // Date 포맷 타입 지정
        
        let date = dateFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환
        print("현재 날짜 : \(date)")

        return date
    }
    
    
    // MARK: - 현재 날짜의 요일을 구하는 함수
    func getNowDayOfTheWeek() ->String {
        let nowDate = Date() // 현재의 Date 날짜 및 시간
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        dateFormatter.dateFormat = "E" // Date 포맷 타입 지정
        
        let date = dateFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환
        print("현재 날짜의 요일 : \(date)")

        return date
    }


    // MARK: - 숫자 키보드 설정 함수
    /// 숫자 키보드 설정 함수
    func setNumKeyBoard() {
        tf_input.keyboardType = .numberPad
    }
    
    
    // MARK: - 기기에 저장된 식수 데이터 불러오는 함수
    func getData() {
        tf_input.text = UserDefaults.standard.string(forKey: "food")
    }
    
}
