//
//  PostManager.swift
//  RentoLib
//
//  Created by Rami Moubayed on 25/02/2021.
//

import Foundation

protocol PostManagerDelegate {
    func PostingPermitted (_ postManager: PostManager,_ JsonResponseMessage: String,_ user: User)
    func PostingFailWithError (errorMessage: String)
}


struct PostManager {
    
    var delegate: PostManagerDelegate?
    
    func postingItem (_ product: Product,_ user: User){
        let urlString = "https://torre-test-301909.appspot.com/product/new"
        
        guard let url = URL(string: urlString) else {
                    print("Error: cannot create URL")
                    return
                }

        guard let jsonData = try? JSONEncoder().encode(product) else {
                    print("Error: Trying to convert model to JSON data")
                    return
                }

        // Create the url request
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
                request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
                request.httpBody = jsonData
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil  else {
                        print("Error: error calling POST")
                        print(error!)
                        print(response!)
                        return
                    }

                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }

                    guard let response = response as? HTTPURLResponse, (200 ..< 600) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        print(error!)
                        return
                    }
                    print("The HTTP REQUEST STATUS CODE IS: \(response.statusCode)")
                    
                    
                    
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Couldn't print JSON in String")
                            return
                        }

                        print("HELLO MIJO \(prettyPrintedJson)")
                        
                        receivedJson = prettyPrintedJson
                        DispatchQueue.main.async {
                                 // Call the rootViewController
                                if receivedJson.contains("wrong") {
                                let JsonResponseData = receivedJson.data(using: .utf8)!
                                let JsonResponse: JSONResponseModel = try! JSONDecoder().decode(JSONResponseModel.self, from: JsonResponseData)
                                print("THE RESPONSE MESSAGE IS: \(JsonResponse.message)")
                                responseMessage = JsonResponse.message
                                delegate?.PostingFailWithError(errorMessage: responseMessage)
                            } else if receivedJson.contains("productId") {
                                responseMessage = "Item Posted"
                                let JsonResponseData = receivedJson.data(using: .utf8)!
                                let JsonResponse: Product = try! JSONDecoder().decode(Product.self, from: JsonResponseData)
                                
                                delegate?.PostingPermitted(self, responseMessage, user)
                            }
                        }
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        print(error)
                        return
                    }
                    
                }.resume()
    }
    
}
