//
//  NetworkApi.swift
//  URLRequestApp
//
//  Created by Artem on 25.02.25.
//


import Foundation

class NetworkApi {
    let apiKey: String = "9ed2d720192d4210ad2173724252302"
    let url: String = "https://api.weatherapi.com/"
    
    func getWeather(city: String, completion: @escaping (ResponceApi?) -> Void) {
        var urlComponents = URLComponents(string: url)
        urlComponents?.path = "/v1/forecast.json"
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: "9ed2d720192d4210ad2173724252302"),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "3"),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "alerts", value: "no")
        ]
        
        guard let url = urlComponents?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, resp, err in
            guard err == nil else {
                print(err!.localizedDescription)
                return
            }
            
            guard let data = data else { return }
                    
            do {
                let result = try JSONDecoder().decode(ResponceApi.self, from: data)
                completion(result)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
