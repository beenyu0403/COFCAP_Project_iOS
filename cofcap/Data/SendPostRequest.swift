//
//  SendPostRequest.swift
//  cofcap
//
//  Created by 김유빈 on 3/4/24.
//

import Foundation

func sendPostRequestMember(_ url: String, parameters: Member, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let targetUrl = URL(string: url)
    //let paramData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
    let encoder = JSONEncoder()
    let encodedData = try? encoder.encode(parameters)
    
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
        
        let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
        completion(responseObject, nil)
    }
    task.resume()
}



func sendPostRequestCoffee(keyword: String, completion: @escaping ([CoffeeElement]?, Error?) -> Void) {
    let targetUrl = URL(string: "http://localhost:8080/api/v2/itemList")
    let encoder = JSONEncoder()
    let bodydata = [
        "keyword" : keyword
    ]
    let encodedData = try? encoder.encode(bodydata)
    
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
        
        let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [[String: Any]]
       // let responseObject = try? JSONDecoder().decode(Coffee.self, from:data)
        var coffeeItems : [CoffeeElement] = []
        var _ : Description = Description(tastingNotes: "", drinksPerBox: 0, suggestedCupSize: 0, roast: "", intensity: 0)
        for object in responseObject! {
            let desany : [String:Any] = object["description"] as! [String : Any]
            coffeeItems.append(CoffeeElement(id: object["id"] as! Int, name: object["name"] as! String, price: object["price"] as! Int, stockQuantity: object["stockQuantity"] as! Int, categories: [], imageName: object["imageName"] as! String, description: Description(tastingNotes: desany["tastingNotes"] as! String, drinksPerBox: desany["drinksPerBox"] as! Int, suggestedCupSize: desany["suggestedCupSize"] as! Int, roast: desany["roast"] as! String, intensity: desany["intensity"] as! Int)))
        }
        //print(coffeeItems[0].description.intensity)
        //completion(responseObject, nil)
        completion(coffeeItems, nil)
    }
    task.resume()
}
