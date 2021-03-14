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
    
    @IBOutlet weak var sourceField: UITextField!
    
    @IBOutlet weak var resultField: UITextField!
    
    @IBAction func btn(_ sender: Any) {
        if let source = sourceField.text {
            self.networkManager.fetchCurrentTranslate(forText: source) { currentTranslate in
                print(currentTranslate.translate)
                DispatchQueue.main.async{
                    self.resultField.text = currentTranslate.translate
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    


}

