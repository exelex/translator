//
//  CurrentTranslateData.swift
//  translator
//
//  Created by Alexey Il on 12.03.2021.
//

import Foundation

struct CurrentTranslate {
    let translate: String
    
    init?(fromTranslateText text: String) {
        translate = text
    }
}
