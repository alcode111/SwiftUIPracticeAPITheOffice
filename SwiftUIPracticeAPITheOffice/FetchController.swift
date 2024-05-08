//
//  FetchController.swift
//  SwiftUIPracticeAPITheOffice
//
//  Created by Ismaïl LP on 21/04/2024.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badURL, badResponse
    }
    
    private let baseURL = URL(string: "https://officeapi.akashrajpurohit.com")!
    
    func fetchQuote() async throws -> Quote {
        let quoteURL = baseURL.appendingPathComponent("quote/random")
        
        let (data, response) = try await URLSession.shared.data(from: quoteURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse
        }
                
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let quote = try decoder.decode(Quote.self, from: data)
        
        return quote
    }
}
