//
//  UserService.swift
//  cofcap
//
//  Created by 김유빈 on 3/15/24.
//

import Foundation
//import Alamofire

class UserService {
    
    static let shared = UserService()
//싱글통 객체를 선언해서 앱 어디에서든지 접근가능하도록 한다
    private init() {}
    

    func login(id: String, password: String, completion: @escaping ([String: String]?, Error?) -> Void) {
        let targetUrl = URL(string: "http://localhost:8080/api/v2/login")
        let encoder = JSONEncoder()
        let body : Login = .init(loginId: id, loginPw: password)
        let encodedData = try? encoder.encode(body)
        
        var request = URLRequest(url: targetUrl!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,                              // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                error == nil                                  // was there no error
            else {
                completion(nil, error)
                return
            }
            
            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: String]
            completion(responseObject, nil)
           
        }
        task.resume()
    }
    
 
}
