//
//  Network.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 02/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decoding(Error)
    case unknown(Error?)
    case parsingError(String)
}

final class Network {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchModel<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<
        T, NetworkError
    >) -> Void) {
        guard let url = URL(string: endpoint.path, relativeTo: endpoint.baseURL) else {
            completion(.failure(.badURL))
            return
        }
        
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }

            let decoder = JSONDecoder()

            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let model = try decoder.decode(T.self, from: jsonData)
                completion(.success(model))
            } catch {
                completion(.failure(.decoding(error)))
            }
        }.resume()
    }
}
