//
//  MenuSection.swift
//  CoolBeans
//
//  Created by Codebucket on 21/09/22.
//

import Foundation

struct MenuSection: Identifiable, Codable{
    let id: UUID
    let name: String
    let drinks: [Drink]
}
