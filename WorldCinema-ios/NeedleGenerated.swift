

import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class RegistrationComponentDependency45ce06ac0365c929bb6bProvider: RegistrationComponentDependency {
    var registrationUseCase: RegistrationUseCase {
        return mainComponent.registrationUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->RegistrationComponent
private func factorybf509de48c6e5261a8800ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RegistrationComponentDependency45ce06ac0365c929bb6bProvider(mainComponent: parent1(component) as! MainComponent)
}
private class AuthorizationComponentDependency01c300e9208281b9a593Provider: AuthorizationComponentDependency {
    var loginUseCase: LoginUseCase {
        return mainComponent.loginUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->AuthorizationComponent
private func factory36d2db3a6303047193540ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthorizationComponentDependency01c300e9208281b9a593Provider(mainComponent: parent1(component) as! MainComponent)
}
private class CollectionComponentDependency3d427c8b4e1d924f27ebProvider: CollectionComponentDependency {


    init() {

    }
}
/// ^->MainComponent->CollectionComponent
private func factoryfc00ae1c9aa628ca4995e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return CollectionComponentDependency3d427c8b4e1d924f27ebProvider()
}
private class ProfileComponentDependency919001f509df49c9c523Provider: ProfileComponentDependency {


    init() {

    }
}
/// ^->MainComponent->ProfileComponent
private func factory85f38151f9d92062292ce3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ProfileComponentDependency919001f509df49c9c523Provider()
}
private class CompilationComponentDependency373fbd2b277d76ee0a2bProvider: CompilationComponentDependency {


    init() {

    }
}
/// ^->MainComponent->CompilationComponent
private func factorya1836deb0193bacd38b4e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return CompilationComponentDependency373fbd2b277d76ee0a2bProvider()
}
private class HomeComponentDependency887e91671f4424758155Provider: HomeComponentDependency {
    var getCoverHomeViewUseCase: GetCoverHomeViewUseCase {
        return mainComponent.getCoverHomeViewUseCase
    }
    var getTokensUseCase: GetTokensUseCase {
        return mainComponent.getTokensUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->HomeComponent
private func factory9bc7b43729f663f093120ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeComponentDependency887e91671f4424758155Provider(mainComponent: parent1(component) as! MainComponent)
}

#else
extension RegistrationComponent: Registration {
    public func registerItems() {
        keyPathToName[\RegistrationComponentDependency.registrationUseCase] = "registrationUseCase-RegistrationUseCase"
    }
}
extension AuthorizationComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthorizationComponentDependency.loginUseCase] = "loginUseCase-LoginUseCase"
    }
}
extension CollectionComponent: Registration {
    public func registerItems() {

    }
}
extension ProfileComponent: Registration {
    public func registerItems() {

    }
}
extension CompilationComponent: Registration {
    public func registerItems() {

    }
}
extension HomeComponent: Registration {
    public func registerItems() {
        keyPathToName[\HomeComponentDependency.getCoverHomeViewUseCase] = "getCoverHomeViewUseCase-GetCoverHomeViewUseCase"
        keyPathToName[\HomeComponentDependency.getTokensUseCase] = "getTokensUseCase-GetTokensUseCase"
    }
}
extension MainComponent: Registration {
    public func registerItems() {


    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->MainComponent->RegistrationComponent", factorybf509de48c6e5261a8800ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->AuthorizationComponent", factory36d2db3a6303047193540ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->CollectionComponent", factoryfc00ae1c9aa628ca4995e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->ProfileComponent", factory85f38151f9d92062292ce3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->CompilationComponent", factorya1836deb0193bacd38b4e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->HomeComponent", factory9bc7b43729f663f093120ae93e637f014511a119)
    registerProviderFactory("^->MainComponent", factoryEmptyDependencyProvider)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
