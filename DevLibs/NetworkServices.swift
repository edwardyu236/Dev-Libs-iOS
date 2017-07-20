//
//  NetworkServices.swift
//  DevLibs
//
//  Created by Edward Yu US1070055 on 7/20/17.
//  Copyright © 2017 vmware-yedward. All rights reserved.
//

import Foundation
import Alamofire

class NetworkServices {
    class func fetchRandomSentence(responseHandler: @escaping (_ template: SentenceTemplate?, _ success: Bool) -> Void) {
        
        Alamofire.request("http://localhost:8080/random").responseJSON { response in
            guard let statusCode = response.response?.statusCode,
                statusCode == 200,
            let json = response.result.value as? NSDictionary,
            let sentence = json["sentence"] as? String,
            let title = json["title"] as? String else {
                    responseHandler(nil, false)
                    print("Fail fetchRandomSentence")
                    return
            }
            let id = json["_id"] as? String
            
            let template = SentenceTemplate(title: title, sentence: sentence, id: id)
            responseHandler(template, true)
            print("Success fetchRandomSentence")
            
        }
    }
    
    class func fetchAllSentences(responseHandler: @escaping (_ templates: [SentenceTemplate]?, _ success: Bool) -> Void) {
        
        var templates = [SentenceTemplate]()
        
        Alamofire.request("http://localhost:8080").responseJSON { response in
            guard let statusCode = response.response?.statusCode,
                statusCode == 200,
                let json = response.result.value as? NSArray else {
                    responseHandler(nil, false)
                    print("Fail 1 fetchAllSentences")
                    return
            }
            
            for item in json {
                guard let dict = item as? NSDictionary,
                    let sentence = dict["sentence"] as? String,
                    let title = dict["title"] as? String else {
                        responseHandler(nil, false)
                        print("Fail 2 fetchAllSentences")
                        return
                }
                let id = dict["_id"] as? String
                let template = SentenceTemplate(title: title, sentence: sentence, id: id)
                templates.append(template)
            }
            
            responseHandler(templates, true)
            print("Success fetchAllSentences")

        }
    }
}
