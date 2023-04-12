//
//  CompilationComponent.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 06.04.2023.
//

import Foundation
import NeedleFoundation

protocol CompilationComponentDependency: Dependency {}

final class CompilationComponent: Component<CompilationComponentDependency> {
    var compilationViewController: CompilationViewController {
        return CompilationViewController()
    }
}
