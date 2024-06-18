//
//  Question.swift
//  Quiz App
//
//  Created by Tomas Sanni on 6/18/24.
//

import Foundation

struct Question {
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        text = q
        answer = a
    }
}
