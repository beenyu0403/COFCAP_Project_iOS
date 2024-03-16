//
//  Member.swift
//  cofcap
//
//  Created by 김유빈 on 3/4/24.
//

import Foundation

// MARK: - Member
struct Member: Codable {
    var name: String
    var login: Login
   // var address: Address
}

// MARK: - Address
//struct Address: Codable {
//    var city, street, zipcode: String
//}

// MARK: - Login
struct Login: Codable {
    var loginId, loginPw: String

    enum CodingKeys: String, CodingKey {
        case loginId = "loginId"
        case loginPw
    }
}

struct IdCheck: Codable {
    let loginId : String
}

class IdCheckData : Codable{
    let name : String
    let checkResult : Bool
}

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

enum NetworkResult<T> {
    case success(T) // 서버 통신 성공함
    case requestError(T) // 요청 에러가 발생함
    case pathError // 경로 에러가 발생함
    case serverError // 서버 내부 에러가 발생함
    case networkFail // 네트워크 연결에 실패함
}
