//
//  Person.swift
//  MVVMExample
//
//  Created by Roman on 08/12/2022.
//

import Foundation

enum Gender {
    case male, female
}

struct Person {
    let name: String
    let birthdate: Date?
    let middleName: String?
    let address: String?
    let gender: Gender
    
    var userName = "Roman"
    
    init(name: String, birthdate: Date? = nil, middleName: String? = nil, address: String? = nil, gender: Gender = .male) {
        self.name = name
        self.birthdate = birthdate
        self.middleName = middleName
        self.address = address
        self.gender = gender
    }

}
