//
//  NetworkManager.swift
//  translator
//
//  Created by Alexey Il on 12.03.2021.
//

import Foundation

struct NetworkManager {
    func fetchCurrentTranslate(forText: String, completionHandler: @escaping (CurrentTranslate) -> Void) {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "x-rapidapi-key": googleTranslateApiKey,
            "x-rapidapi-host": "google-translate1.p.rapidapi.com"
        ]

        let postData = NSMutableData(data: "q=\(forText)".data(using: String.Encoding.utf8)!)
        postData.append("&source=en".data(using: String.Encoding.utf8)!)
        postData.append("&target=ru".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if let data = data {
                print(forText)
                let translatedText = self.parseJSON(withData: data)
                guard let currentTranslate = CurrentTranslate(fromTranslateText: translatedText) else { return }
                completionHandler(currentTranslate)
            }
        })

        task.resume()
    }
    
    
    func parseJSON(withData data: Data) -> String {
        
        do {
            let dataString = String(data: data, encoding: .utf8)
            print(dataString)
            if let json = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                if let jsonData = json["data"] as? [String : Any] {
                    if let translations = jsonData["translations"] as? [NSDictionary] {
                        if let translation = translations.first as? [String : Any] {
                            if let translatedText = translation["translatedText"] as? String {
                                return translatedText
                            }
                        }
                    }
                }
            }
        } catch {
            print("Serialization failed: \(error.localizedDescription)")
        }
        
        return "Translate error"
        
    }
}
