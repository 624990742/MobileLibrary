//
//  File.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/9.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
extension Array {
    func randomElement() -> Element? {
        guard !isEmpty else { return nil }
        
        let randomIndex = Int.random(in: 0..<count)
        return self[randomIndex]
    }
}
