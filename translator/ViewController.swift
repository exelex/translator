//
//  ViewController.swift
//  translator
//
//  Created by Alexey Il on 11.03.2021.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {

    let networkManager = NetworkManager()
    
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var sourceField: UITextField!
    @IBOutlet weak var resultField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnHistory.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    
    private func saveTranslate(title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "History", in: context) else { return }
        
        let taskObject = History(entity: entity, insertInto: context)
        taskObject.translate = title
        
        do {
            try context.save()
            print("save")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func btnResultTapped(_ sender: UIButton) {
        if let source = sourceField.text {
            self.networkManager.fetchCurrentTranslate(forText: source) { currentTranslate in
                DispatchQueue.main.async{
                    self.resultField.text = currentTranslate.translate
                    
                    let sourceText = self.sourceField.text ?? ""
                    let resultText = self.resultField.text ?? ""
                    
                    self.saveTranslate(title: "\(sourceText) - \(resultText)")
                }
            }
        }
    }
    


}

