//
//  MovieComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 14.04.2023.
//

import Foundation
import NeedleFoundation
import UIKit

protocol MovieComponentProvider: Dependency {
    
}


final class MovieComponent: Component <MovieComponentProvider> {
    
    var movieViewController: UIViewController {
        return MovieViewController()
    }
}
