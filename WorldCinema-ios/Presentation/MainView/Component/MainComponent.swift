//
//  MainComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 24.03.2023.
//

import Foundation
import NeedleFoundation
import UIKit

final class MainComponent: BootstrapComponent {
    var jsonDecoder: JSONDecoder {
        shared {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            return decoder
        }
    }

    var jsonEncoder: JSONEncoder {
        shared {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601

            return encoder
        }
    }
    
    var requestInterceptor: RequestInterceptor {
        shared {
            RequestInterceptor(
                saveTokensUseCase: saveTokensUseCase,
                getTokensUseCase: getTokensUseCase,
                refreshTokenUseCase: refreshTokenUseCase,
                logoutUseCase: logOutUseCase
            )
        }
    }
    
    var keychainRepository: KeychainRepository {
        shared {
            KeychainRepositoryImpl()
        }
    }
    
    var authRepository: AuthorizationRepository {
        shared {
            AuthRepositoryImpl(jsonDecoder: jsonDecoder,
                               jsonEncoder: jsonEncoder)
        }
    }
    
    var getHomeCoverRepository: GetHomeCoverRepository {
        shared {
            GetCoverRepositoryImpl(jsonDecoder: jsonDecoder,
                                   jsonEncoder: jsonEncoder,
                                   requestInterceptor: requestInterceptor)
        }
    }
    
    var profileRepository: ProfileRepository {
        shared {
            ProfileRepositoryImpl(jsonDecoder: jsonDecoder,
                                  jsonEncoder: jsonEncoder,
                                  requestInterceptor: requestInterceptor)
        }
    }
    
    var movieRepository: MovieRepository {
        shared {
            MovieRepositoryImpl(jsonDecoder: jsonDecoder,
                                jsonEncoder: jsonEncoder,
                                requestInterceptor: requestInterceptor)
        }
    }
    
    var getInTrendMovieUseCase: GetInTrendMovieUseCase {
        shared {
            GetInTrendMovieUseCase(movieRepository: movieRepository)
        }
    }
    
    var getNewMovieUseCase: GetNewMovieUseCase {
        shared {
            GetNewMovieUseCase(movieRepository: movieRepository)
        }
    }
    
    var getLastViewMovieUseCase: GetLastViewMovieUseCase {
        shared {
            GetLastViewMovieUseCase(movieRepository: movieRepository)
        }
    }
    
    var getForMeMovieUseCase: GetForMeMovieUseCase {
        shared {
            GetForMeMovieUseCase(movieRepository: movieRepository)
        }
    }
    
    var saveAuthStatusUseCase: SaveAuthStatusUseCase {
        shared {
            SaveAuthStatusUseCase()
        }
    }

    var getAuthStatusUseCase: GetAuthStatusUseCase {
        shared {
            GetAuthStatusUseCase()
        }
    }
    
    var saveTokensUseCase: SaveTokensUseCase {
        shared {
            SaveTokensUseCase(keychainRepository: keychainRepository)
        }
    }

    var getTokensUseCase: GetTokensUseCase {
        shared {
            GetTokensUseCase(keychainRepository: keychainRepository)
        }
    }

    var registrationUseCase: RegistrationUseCase {
        shared {
            RegistrationUseCase(authorizationRepository: authRepository,
                                saveTokensUseCase: saveTokensUseCase,
                                saveAuthStatusUseCase: saveAuthStatusUseCase)
        }
    }
    
    var loginUseCase: LoginUseCase {
        shared {
            LoginUseCase(authorizationRepository: authRepository,
                         saveTokensUseCase: saveTokensUseCase,
                         saveAuthStatusUseCase: saveAuthStatusUseCase)
        }
    }
    
    var refreshTokenUseCase: RefreshTokenUseCase {
        shared {
            RefreshTokenUseCase(authRepository: authRepository)
        }
    }
    
    var logOutUseCase: LogOutUseCase {
        shared {
            LogOutUseCase(saveTokensUseCase: saveTokensUseCase)
        }
    }
    
    var getCoverHomeViewUseCase: GetCoverHomeViewUseCase {
        shared {
            GetCoverHomeViewUseCase(getHomeCoverRepository: getHomeCoverRepository)
        }
    }
    
    var getProfileDataUseCase: GetProfileDataUseCase {
        shared {
            GetProfileDataUseCase(profileRepository: profileRepository)
        }
    }
    
    var uploadProfileDataUseCase: UploadProfileDataUseCase {
        shared {
            UploadProfileDataUseCase(profileRepository: profileRepository)
        }
    }
    
    var authorizationComponent: AuthorizationComponent {
        shared {
            AuthorizationComponent(parent: self)
        }
    }

    var registrationComponent: RegistrationComponent {
        shared {
            RegistrationComponent(parent: self)
        }
    }
    
    var compilationComponent: CompilationComponent {
        shared {
            CompilationComponent(parent: self)
        }
    }
    
    var collectionComponent: CollectionComponent {
        shared {
            CollectionComponent(parent: self)
        }
    }
    
    var movieComponent: MovieComponent {
        shared {
            MovieComponent(parent: self)
        }
    }
    
    var profileComponent: ProfileComponent {
        shared {
            ProfileComponent(parent: self)
        }
    }
    
    var homeComponent: HomeComponent {
        shared {
            HomeComponent(parent: self)
        }
    }

    var mainViewController: UIViewController {
        return MainViewController()
    }
}
