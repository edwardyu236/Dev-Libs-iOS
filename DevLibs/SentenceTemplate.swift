//
//  SentenceTemplate.swift
//  DevLibs
//
//  Created by Edward Yu US1070055 on 7/20/17.
//  Copyright © 2017 vmware-yedward. All rights reserved.
//

import Foundation

class SentenceTemplate {
    var id: String?
    var title: String
    var sentence: String
    
    init(title: String, sentence: String, id: String? = nil) {
        self.title = title
        self.sentence = sentence
        self.id = id
    }
    
    lazy var blanks: [String] = self.getBlanks()
    
    func getBlanks() -> [String] {
        let regex = "\\{\\{\\w*\\}\\}"
        return matches(for: regex, in: sentence)
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func generateSentence(using blanksAndReplacements: [(String, String)]) -> String {
        var sentenceInProgress = sentence
        for (blank, replacement) in blanksAndReplacements {
            sentenceInProgress = sentenceInProgress.stringByReplacingFirstOccurrenceOfString(target: blank, withString: replacement)
        }
        return sentenceInProgress
    }
}

func stripBraces(blank: String) -> String {
    var stringInProgress = blank
    stringInProgress = stringInProgress.replacingOccurrences(of: "{", with: "")
    stringInProgress = stringInProgress.replacingOccurrences(of: "}", with: "")
    return stringInProgress
}


extension String
{
    func stringByReplacingFirstOccurrenceOfString(
        target: String, withString replaceString: String) -> String
    {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
}
