//
//  ViewController.swift
//  translator
//
//  Created by Alexey Il on 11.03.2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let networkManager = NetworkManager()
    
    var translateArray: [Translate] = []
    
    @IBOutlet weak var btnHistory: UIButton!
    
    
    @IBOutlet weak var sourceField: UITextField!
    
    @IBOutlet weak var resultField: UITextField!
    
    @IBAction func btn(_ sender: Any) {
        if let source = sourceField.text {
            self.networkManager.fetchCurrentTranslate(forText: source) { currentTranslate in
                DispatchQueue.main.async{
                    self.resultField.text = currentTranslate.translate
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnHistory.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
    }
    


}

