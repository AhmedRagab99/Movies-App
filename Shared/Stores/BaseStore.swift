//
//  BaseStore.swift
//
//  Created by Ahmed Ragab on 08/05/2022.
//

import Foundation

protocol MoviesAppBaseStoreProtocol {
    func loadURLAndDecode<D:Codable>(url: URL, params: [String: String]?) async throws -> D
}

class MoviesAppBaseStore:MoviesAppBaseStoreProtocol{

    // MARK: - properties
    private let jsonDecoder = Utils.jsonDecoder
    private let urlSession = URLSession.shared
    
    //MARK: - functions
    func loadURLAndDecode<D:Codable>(url: URL, params: [String : String]?) async throws -> D {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw MoviesAppError.invalidEndPoints
        }
        
        var quaryItems = [URLQueryItem(name: "api_key", value: ProcessInfo.processInfo.environment["ApiKey"])]
        if let params = params {
            quaryItems.append(contentsOf: params.map{URLQueryItem(name: $0.key, value: $0.value)})
        }
        urlComponents.queryItems = quaryItems
        guard let finalUrl = urlComponents.url else { throw MoviesAppError.invalidEndPoints }
        
        let (data,response) = try await urlSession.data(from:finalUrl)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            
//            throw   NSError(domain: "error code", code: 123, userInfo: [NSLocalizedDescriptionKey:response])
            
            throw MoviesAppError.invalidResponse
        }
        do {
            let result  = try jsonDecoder.decode(D.self, from: data)
            print("result from decoder",result)
            return result
        } catch(let error) {
            print("error",error.localizedDescription)
            throw MoviesAppError.noData
        }
    }
}
