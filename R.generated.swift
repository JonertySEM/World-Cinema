//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var font: font { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func font(bundle: Foundation.Bundle) -> font {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.font.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var localizable: localizable { .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale)) }

    func localizable(preferredLanguages: [String]) -> localizable {
      .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.localizable` struct is generated, and contains static references to 25 localization keys.
    struct localizable {
      let source: RswiftResources.StringResource.Source

      /// en translation: Add prefers
      ///
      /// Key: addPrefers
      ///
      /// Locales: en, ru
      var addPrefers: RswiftResources.StringResource { .init(key: "addPrefers", tableName: "Localizable", source: source, developmentValue: "Add prefers", comment: nil) }

      /// en translation: Collection
      ///
      /// Key: collectionPage
      ///
      /// Locales: en, ru
      var collectionPage: RswiftResources.StringResource { .init(key: "collectionPage", tableName: "Localizable", source: source, developmentValue: "Collection", comment: nil) }

      /// en translation: Compilation
      ///
      /// Key: compilation
      ///
      /// Locales: en, ru
      var compilation: RswiftResources.StringResource { .init(key: "compilation", tableName: "Localizable", source: source, developmentValue: "Compilation", comment: nil) }

      /// en translation: Confrim password
      ///
      /// Key: confrimPassword
      ///
      /// Locales: en, ru
      var confrimPassword: RswiftResources.StringResource { .init(key: "confrimPassword", tableName: "Localizable", source: source, developmentValue: "Confrim password", comment: nil) }

      /// en translation: E-mail
      ///
      /// Key: email
      ///
      /// Locales: en, ru
      var email: RswiftResources.StringResource { .init(key: "email", tableName: "Localizable", source: source, developmentValue: "E-mail", comment: nil) }

      /// en translation: First name
      ///
      /// Key: firstName
      ///
      /// Locales: en, ru
      var firstName: RswiftResources.StringResource { .init(key: "firstName", tableName: "Localizable", source: source, developmentValue: "First name", comment: nil) }

      /// en translation: For you
      ///
      /// Key: forYou
      ///
      /// Locales: en, ru
      var forYou: RswiftResources.StringResource { .init(key: "forYou", tableName: "Localizable", source: source, developmentValue: "For you", comment: nil) }

      /// en translation: I already have an account
      ///
      /// Key: haveAccount
      ///
      /// Locales: en, ru
      var haveAccount: RswiftResources.StringResource { .init(key: "haveAccount", tableName: "Localizable", source: source, developmentValue: "I already have an account", comment: nil) }

      /// en translation: Main
      ///
      /// Key: homePage
      ///
      /// Locales: en, ru
      var homePage: RswiftResources.StringResource { .init(key: "homePage", tableName: "Localizable", source: source, developmentValue: "Main", comment: nil) }

      /// en translation: In trends
      ///
      /// Key: inTrends
      ///
      /// Locales: en, ru
      var inTrends: RswiftResources.StringResource { .init(key: "inTrends", tableName: "Localizable", source: source, developmentValue: "In trends", comment: nil) }

      /// en translation: The problem is on the server side
      ///
      /// Key: internalServerError
      ///
      /// Locales: en, ru
      var internalServerError: RswiftResources.StringResource { .init(key: "internalServerError", tableName: "Localizable", source: source, developmentValue: "The problem is on the server side", comment: nil) }

      /// en translation: Invalid email or password
      ///
      /// Key: invalidUserCredentials
      ///
      /// Locales: en, ru
      var invalidUserCredentials: RswiftResources.StringResource { .init(key: "invalidUserCredentials", tableName: "Localizable", source: source, developmentValue: "Invalid email or password", comment: nil) }

      /// en translation: Loading
      ///
      /// Key: loading
      ///
      /// Locales: en, ru
      var loading: RswiftResources.StringResource { .init(key: "loading", tableName: "Localizable", source: source, developmentValue: "Loading", comment: nil) }

      /// en translation: New films
      ///
      /// Key: newFilms
      ///
      /// Locales: en, ru
      var newFilms: RswiftResources.StringResource { .init(key: "newFilms", tableName: "Localizable", source: source, developmentValue: "New films", comment: nil) }

      /// en translation: Password
      ///
      /// Key: password
      ///
      /// Locales: en, ru
      var password: RswiftResources.StringResource { .init(key: "password", tableName: "Localizable", source: source, developmentValue: "Password", comment: nil) }

      /// en translation: Register
      ///
      /// Key: pressRegistrationButton
      ///
      /// Locales: en, ru
      var pressRegistrationButton: RswiftResources.StringResource { .init(key: "pressRegistrationButton", tableName: "Localizable", source: source, developmentValue: "Register", comment: nil) }

      /// en translation: Profile
      ///
      /// Key: profile
      ///
      /// Locales: en, ru
      var profile: RswiftResources.StringResource { .init(key: "profile", tableName: "Localizable", source: source, developmentValue: "Profile", comment: nil) }

      /// en translation: Registration
      ///
      /// Key: registration
      ///
      /// Locales: en, ru
      var registration: RswiftResources.StringResource { .init(key: "registration", tableName: "Localizable", source: source, developmentValue: "Registration", comment: nil) }

      /// en translation: Second name
      ///
      /// Key: secondName
      ///
      /// Locales: en, ru
      var secondName: RswiftResources.StringResource { .init(key: "secondName", tableName: "Localizable", source: source, developmentValue: "Second name", comment: nil) }

      /// en translation: Sign In
      ///
      /// Key: signIn
      ///
      /// Locales: en, ru
      var signIn: RswiftResources.StringResource { .init(key: "signIn", tableName: "Localizable", source: source, developmentValue: "Sign In", comment: nil) }

      /// en translation: Unable to get data
      ///
      /// Key: unableToGetData
      ///
      /// Locales: en, ru
      var unableToGetData: RswiftResources.StringResource { .init(key: "unableToGetData", tableName: "Localizable", source: source, developmentValue: "Unable to get data", comment: nil) }

      /// en translation: A user with such an email already exists
      ///
      /// Key: userAlreadyExists
      ///
      /// Locales: en, ru
      var userAlreadyExists: RswiftResources.StringResource { .init(key: "userAlreadyExists", tableName: "Localizable", source: source, developmentValue: "A user with such an email already exists", comment: nil) }

      /// en translation: Watch
      ///
      /// Key: watch
      ///
      /// Locales: en, ru
      var watch: RswiftResources.StringResource { .init(key: "watch", tableName: "Localizable", source: source, developmentValue: "Watch", comment: nil) }

      /// en translation: Wrong user credentials
      ///
      /// Key: wrongUserCredentials
      ///
      /// Locales: en, ru
      var wrongUserCredentials: RswiftResources.StringResource { .init(key: "wrongUserCredentials", tableName: "Localizable", source: source, developmentValue: "Wrong user credentials", comment: nil) }

      /// en translation: You watched
      ///
      /// Key: youWatched
      ///
      /// Locales: en, ru
      var youWatched: RswiftResources.StringResource { .init(key: "youWatched", tableName: "Localizable", source: source, developmentValue: "You watched", comment: nil) }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 2 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `LauchScreenBackground`.
    var lauchScreenBackground: RswiftResources.ColorResource { .init(name: "LauchScreenBackground", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 9 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `LauchScreenLogo`.
    var lauchScreenLogo: RswiftResources.ImageResource { .init(name: "LauchScreenLogo", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `cover`.
    var cover: RswiftResources.ImageResource { .init(name: "cover", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `messageMovieProfile`.
    var messageMovieProfile: RswiftResources.ImageResource { .init(name: "messageMovieProfile", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `sadTV`.
    var sadTV: RswiftResources.ImageResource { .init(name: "sadTV", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `settingMovieProfile`.
    var settingMovieProfile: RswiftResources.ImageResource { .init(name: "settingMovieProfile", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `shadow`.
    var shadow: RswiftResources.ImageResource { .init(name: "shadow", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `stackMovie`.
    var stackMovie: RswiftResources.ImageResource { .init(name: "stackMovie", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `timeMovieProfile`.
    var timeMovieProfile: RswiftResources.ImageResource { .init(name: "timeMovieProfile", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `tiviMovie`.
    var tiviMovie: RswiftResources.ImageResource { .init(name: "tiviMovie", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.font` struct is generated, and contains static references to 2 fonts.
  struct font: Sequence {
    let bundle: Foundation.Bundle

    /// Font `SFProText-Bold`.
    var sfProTextBold: RswiftResources.FontResource { .init(name: "SFProText-Bold", bundle: bundle, filename: "SFProText-Bold.ttf") }

    /// Font `SFProText-Regular`.
    var sfProTextRegular: RswiftResources.FontResource { .init(name: "SFProText-Regular", bundle: bundle, filename: "SFProText-Regular.ttf") }

    func makeIterator() -> IndexingIterator<[RswiftResources.FontResource]> {
      [sfProTextBold, sfProTextRegular].makeIterator()
    }
    func validate() throws {
      for font in self {
        if !font.canBeLoaded() { throw RswiftResources.ValidationError("[R.swift] Font '\(font.name)' could not be loaded, is '\(font.filename)' added to the UIAppFonts array in this targets Info.plist?") }
      }
    }
  }

  /// This `_R.file` struct is generated, and contains static references to 2 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `SFProText-Bold.ttf`.
    var sfProTextBoldTtf: RswiftResources.FileResource { .init(name: "SFProText-Bold", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `SFProText-Regular.ttf`.
    var sfProTextRegularTtf: RswiftResources.FileResource { .init(name: "SFProText-Regular", pathExtension: "ttf", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `Launch Screen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "Launch Screen"
      func validate() throws {
        if UIKit.UIImage(named: "LauchScreenLogo", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'LauchScreenLogo' is used in storyboard 'Launch Screen', but couldn't be loaded.") }
      }
    }
  }
}