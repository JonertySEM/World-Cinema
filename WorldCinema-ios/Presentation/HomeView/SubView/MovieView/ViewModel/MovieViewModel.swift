//
//  MovieViewModel.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 15.04.2023.
//

import Foundation
import Combine

class MovieViewModel: FlowController {
    var completionHandler: ((String?) -> ())?
    var completionHandlerButton: ((MovieResponse?) -> ())?
    
    @Published var film = MovieResponse()
    
    
    func getFilmData(filmData: MovieResponse) {
        film = filmData
    }
    
    
    
}
