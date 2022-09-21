//
//  ConfiguratioOption.swift
//  CoolBeans
//
//  Created by Codebucket on 21/09/22.
//

import Foundation

struct ConfigurationOption: Identifiable, Codable, Hashable{
    let id: UUID
    let name: String
    let calories: Int
    
    static let none = ConfigurationOption(id: UUID(), name: "None", calories: 0)
}
