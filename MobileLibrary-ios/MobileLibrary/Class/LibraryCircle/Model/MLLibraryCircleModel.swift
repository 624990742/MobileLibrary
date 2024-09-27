//
//  File.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/28.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation

class MLLibraryCircleModel : MLBaseSwiftModel {
    var id: String = ""
    var bookId: String = ""
    var bookTitle: String = ""
    var bookISBN: String = ""
    var bookCover: String = ""
    var bookAuthor: String = ""
    var bookPress: String = ""
    var bookBrief: String = ""
    var bookCategory: String = ""
    
    
    func mapping(mapper: HelpingMapper) {
        
    }
}
