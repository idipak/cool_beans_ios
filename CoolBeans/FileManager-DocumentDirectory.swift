//
//  FileManager-DocumentDirectory.swift
//  CoolBeans
//
//  Created by Codebucket on 21/09/22.
//

import Foundation

extension FileManager{
    static var documentDirectory: URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
}
