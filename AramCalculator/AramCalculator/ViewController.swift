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
    
    @IBOutlet weak var view_calculate: UIView!
    @IBOutlet weak var view_left: UIView!

    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        print("switchViews start")
        if sender.selectedSegmentIndex == 0 {
            view_calculate.alpha = 1.0
            view_left.alpha = 0.0
            print("view1")
        } else {
            view_calculate.alpha = 0.0
            view_left.alpha = 1.0
            print("view2")
        }
    }
    

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeRounded()
    }
    
    
    func makeRounded() {
        view_calculate.layer.cornerRadius = 15
        view_calculate.layer.masksToBounds = true
        
        view_left.layer.cornerRadius = 15
        view_left.layer.masksToBounds = true
    }
    
    
    
}

