//
//  ModelData.swift
//  Translate
//
//  Created by Babypowder on 11/3/2567 BE.
//

import Foundation

func translateText(text: String, sourceLang: String, targetLang: String, completion: @escaping (String) -> Void) {
    let headers = [
        "content-type": "application/json",
        "X-RapidAPI-Key": "21a01c9c1cmshd5b97a7032862a4p14d3fbjsnf03b3e97aa95",
        "X-RapidAPI-Host": "swift-translate.p.rapidapi.com"
    ]

    let parameters = [
        "text": text,
        "sourceLang": sourceLang,
        "targetLang": targetLang
    ] as [String: Any]

    let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])

    let request = NSMutableURLRequest(url: NSURL(string: "https://swift-translate.p.rapidapi.com/translate")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = postData

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion("Translation error")
            } else if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let translatedText = jsonResponse["translatedText"] as? String {
                            DispatchQueue.main.async {
                                completion(translatedText)
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion("Translation failed")
                            }
                        }
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion("Translation failed")
                    }
                }
            }
        }

    dataTask.resume()
}

func languageCode(for language: String) -> String {
    switch language {
    case "English": return "en"
    case "Thai": return "th"
    case "Spanish": return "es"
    case "French": return "fr"
    case "German": return "de"
    default: return "en"
    }
}
