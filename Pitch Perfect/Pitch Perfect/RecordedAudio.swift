//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Anderson Konzen on 3/12/15.
//  Copyright (c) 2015 Anderson Konzen. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(title: String, filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl        
    }
}