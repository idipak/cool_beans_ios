//
//  Serving.swift
//  CoolBeans
//
//  Created by Codebucket on 21/09/22.
//

import Foundation

struct Serving: Identifiable, Codable{
    var id: UUID
    let name: String
    let description: String
    let caffeine: Int
    let calories: Int
}
