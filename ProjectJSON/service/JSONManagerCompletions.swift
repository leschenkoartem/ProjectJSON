//
//  JSONManager.swift
//  ProjectJSON
//
//  Created by Artem Leschenko on 30.03.2023.
//

import Foundation

class ManagerCompletions{
    static var shared = ManagerCompletions()
    private init(){}
    
    private func createURL() -> URL? {
        let urlStr = "https://dummyjson.com/products"
        
        return URL(string: urlStr)
    }
    
    func fetchData(completion: @escaping (Result<Posts, Error>) -> Void) {
        guard let url = createURL() else { completion(.failure(Errors.badUrl)); return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let usersDate = try decoder.decode(Posts.self, from: data)
                completion(.success(usersDate))
            } catch {
                completion(.failure(Errors.invalidDate))
            }
            
        }.resume()
    }
}

enum Errors: Error {
    case badUrl, invalidDate
}
