//
//  HttpRequestHelper.swift
//  DriivzApp
//
//  Created by Yechiel Amar on 28/03/2023.
//

import Foundation

class HttpRequestHelper {
    func GET(url: String, complete: @escaping (Bool, Data?) -> ()) {
        guard let components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }

        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            
            complete(true, data)
        }.resume()
    }
}
