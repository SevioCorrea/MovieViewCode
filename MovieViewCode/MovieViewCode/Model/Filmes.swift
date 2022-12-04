//
//  Filmes.swift
//  MovieViewCode
//
//  Created by Sévio Basilio Corrêa on 29/11/22.
//

import Foundation

struct MovieResults: Codable {
    let results: [Filmes]
}

struct Filmes: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let image: String?
    let overview: String
    let voteAverage: Double
    let popularity: Double
    let vote_count: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case image = "poster_path"
        case overview
        case voteAverage = "vote_average"
        case popularity
        case vote_count
    }
}

extension Filmes: CustomStringConvertible {
    var description: String {
        let formattedValue = String(format: "%.f", popularity, vote_count)
        return "\(formattedValue)"
    }
    
    func formatPoints(from: Double) -> String {
        
        let number = Double(from)
        let finalNumber = number.formatted(.number.notation(.compactName).locale(.init(identifier: "en_US"))) // Apenas disponível no iOS 15 pra cima
        
        
//        switch finalNumber {
//        case 0...999999:
//            let finalNumber = finalNumber / 1000
//            return ("\(round(finalNumber*10)/10)K")
//
//        case 999999...999999999:
//            let finalNumber = finalNumber / 1000000
//            return "\(round(finalNumber*10)/10)M"
//
//            let finalNumber = finalNumber / 1000000000
//            return "\(round(finalNumber*10)/10)B"
//        default:
//            print("Default")
//        }
//
       return "\(finalNumber)"
    }

}
