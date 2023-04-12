//
//  HomeCoordinator.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 04.04.2023.
//

import Foundation
import UIKit

class HomeCoordinator: NSObject, Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators = [Coordinator]()
    
    var tabBarNavigationController: UITabBarController
    
    var navigationController: UINavigationController
    
    var flowCompletionHendler: CoordinatorHendler?
    
    private let moduleFactory = ModuleFactory()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarNavigationController = .init()
    }
    
    func start() {
        
       let pages: [TabBarEnum] = [.homeView, .compilationView, .collectionView, .profileView]
           .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })

        let controllers: [UINavigationController] = pages.map({ getTabController($0) })

        prepareTabBarController(withTabControllers: controllers)
        
        //showHomeMovieModule()
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarNavigationController.delegate = self
        

        tabBarNavigationController.setViewControllers(tabControllers, animated: true)
        
        tabBarNavigationController.selectedIndex = TabBarEnum.homeView.pageOrderNumber()
       
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            
            let barTintColor: UIColor = .black
            tabBarAppearance.backgroundColor = barTintColor
            
            updateTabBarItemAppearance(appearance: tabBarAppearance.compactInlineLayoutAppearance)
            updateTabBarItemAppearance(appearance: tabBarAppearance.inlineLayoutAppearance)
            updateTabBarItemAppearance(appearance: tabBarAppearance.stackedLayoutAppearance)
            
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        
        UITabBar.appearance().tintColor = .red

        UITabBar.appearance().isTranslucent = false
        
        navigationController.viewControllers = [tabBarNavigationController]
    }
    
    private func updateTabBarItemAppearance(appearance: UITabBarItemAppearance) {
        let tintColor: UIColor = .red
        let unselectedItemTintColor: UIColor = .gray
        
        appearance.selected.iconColor = tintColor
        appearance.normal.iconColor = unselectedItemTintColor
    }
      
    private func getTabController(_ page: TabBarEnum) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.addIconInTabBar(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .homeView:
            let controller = moduleFactory.createHomeModule()
            
            controller.viewModel.completionHandler = { [weak self] _ in
                self?.finish()
                self?.showLoginFlow()

            }
            
            navController.pushViewController(controller, animated: true)
           
        case .compilationView:
            let controller = moduleFactory.createCompilationModule()
            
            navController.pushViewController(controller, animated: true)
        case .collectionView:
            let controller = moduleFactory.createColectionModule()
            
            navController.pushViewController(controller, animated: true)
        case .profileView:
            let controller = moduleFactory.createProfileModule()
            
            
            
            controller.viewModel.completionHandler = { [weak self] _ in
                self?.finish()
                self?.showLoginFlow()

            }
            
            
             navController.pushViewController(controller, animated: true)
        }
        
        
        return navController
    }
    
    func currentPage() -> TabBarEnum? { TabBarEnum.init(index: tabBarNavigationController.selectedIndex) }

    func selectPage(_ page: TabBarEnum) {
        tabBarNavigationController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarEnum.init(index: index) else { return }
        
        tabBarNavigationController.selectedIndex = page.pageOrderNumber()
    }
    
    private func showLoginFlow() {
        let authCoordinator = CoordinatorFactory().createAuthorizationCoordinator(navigationController: navigationController)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
}


extension HomeCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        
    }
}
