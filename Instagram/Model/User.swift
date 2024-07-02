//
//  User.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import Foundation

struct User {
    var uid: String
    var email: String
    var password: String
    var name: String
    var userName: String
    var birthdate: String
    
    init(uid: String, email: String, password: String, name: String, userName: String, birthdate: String) {
        self.uid = uid
        self.email = email
        self.password = password
        self.name = name
        self.userName = userName
        self.birthdate = birthdate
    }
    
    func toDictionary() -> [String: Any] {
        return ["uid": uid,
                "email": email,
                "password": password,
                "name": name,
                "userName": userName,
                "birthdate": birthdate
        ]
    }
    
}

