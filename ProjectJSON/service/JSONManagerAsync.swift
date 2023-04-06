//
//  JSONManagerAsync.swift
//  ProjectJSON
//
//  Created by Artem Leschenko on 06.04.2023.
//

import Foundation

class ManagerAsync{
    static var shared = ManagerAsync()
    private init(){}
    
    private func createURL() -> URL? {
        let urlStr = "https://dummyjson.com/products"
        
        return URL(string: urlStr)
    }
    
    func fetchData() async throws -> Posts {
        guard let url = createURL() else { throw Errors.badUrl }
        let response = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let result = try decoder.decode(Posts.self, from: response.0)
       
        return result
    }
}
