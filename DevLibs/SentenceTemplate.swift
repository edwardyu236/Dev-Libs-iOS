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
}
