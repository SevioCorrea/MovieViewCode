//
//  Network.swift
//  MovieViewCode
//
//  Created by Sévio Basilio Corrêa on 29/11/22.
//

import Foundation

class Network {
    
    private func getURLPopularMovies() -> String {
        let APIKey = "65505ca00f087a4d2b5b28a3f15f7374"
        return "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKey)&language=pt-BR&page=1"
    }
    
    func fetchPopularMovies(_ completion: @escaping ([Filmes]) -> ()) {
        let url = URL(string: getURLPopularMovies())!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(MovieResults.self, from: data)
                completion(result.results)
            } catch {
                print("Não foi possível decodificar o JSON")
            }
        }
        task.resume()
    }
    
}
