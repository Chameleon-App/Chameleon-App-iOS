//
//  AuthenticationTokenModel.swift
//  chameleon
//
//  Created by Ilia Chub on 19.12.2023.
//

struct AuthenticationTokenModel: Decodable {
    let username: String
    let password: String
    let token: String
}
