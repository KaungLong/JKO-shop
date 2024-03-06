//
//  NetworkService.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation
import UIKit

class NetworkService {
    static let shared = NetworkService()

    private init() {}

    func request<T: Decodable>(endpoint: ConnectAPI.Link, decodingTo type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = NetworkConfig.targetBaseUrl + endpoint.rawValue
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "NetworkService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "NetworkService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    // Configure your decoder (e.g., dateDecodingStrategy) as needed
                    let decodedObject = try decoder.decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func loadImage(url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    imageView.image = image
                }
            }
        }.resume()
    }
}


struct ConnectAPI {
    enum Link: String {
        case empty = ""
        case getAllProduct = "products"
    }
}

enum NetworkConfig {
    private static let FORMAL_URL = "https://api.escuelajs.co"
    private static let Test_URL = "https://api.escuelajs.co.Test"
    private static let BASE_URL = "/api/v1/"

    // get desire Link
    static var targetBaseUrl: String {
        FORMAL_URL + BASE_URL
    }
}
