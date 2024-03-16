//
//  LoginModel.swift
//  cofcap
//
//  Created by 김유빈 on 3/15/24.
//

import Foundation

struct LogInResponse : Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: SignInData?
}
struct SignInData: Codable {
    let successLoginId: String
}
