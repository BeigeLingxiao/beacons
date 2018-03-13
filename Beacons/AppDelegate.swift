//
//  AppDelegate.swift
//  Beacons
//
//  Created by Антон Назаров on 21.09.17.
//  Copyright © 2017 Epam. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Swinject
import SwinjectAutoregistration
import RealmSwift

let log = SwiftyBeaver.self
var store: Store!

let filename: URL = {
  let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
  return paths[0].appendingPathComponent("/output.txt")
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  let assembly = Assembler(MainAssembler.getAssemblies())

  //swiftlint:disable:next line_length
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // for unit tests
    //    #if MOCK
    //      return true
    //    #else
    store = Store(state: assembly.resolver ~> State.self)
    configLogger()
    registerSettings()
    registerGMKey()
    logBuildInfo()
    window = createWindow()
    return true
    //    #endif
  }
}

// MARK: - Window
private extension AppDelegate {
  func createWindow() -> UIWindow {
    return UIWindow(frame: UIScreen.main.bounds).then {
      $0.backgroundColor = UIColor.white
      $0.makeKeyAndVisible()
      $0.rootViewController = UINavigationController(rootViewController: assembly.resolver ~> BuildingListViewController.self)
    }
  }
}

// MARK: - Configure logger
private extension AppDelegate {
  func configLogger() {
    log.addDestination(ConsoleDestination())
    //TODO move tokens to user default
    let platform = SBPlatformDestination(
      appID: "nXOo3O",
      appSecret: "4batxlovrtbwPdahNPxOrnf9jrRc36qf",
      encryptionKey: "7z88lblgcbipputaezNjDcgklzag5h5g"
    )
    let file = FileDestination()
    file.logFileURL = filename
    log.addDestination(file)
    log.addDestination(platform)
  }

  func logBuildInfo() {
    log.info(Banner.NAME.rawValue)
    log.info(Configuration.BANNER)
    log.info(Realm.Configuration.defaultConfiguration.fileURL ?? "")
  }
}

// MARK: - Configure GMApi
private extension AppDelegate {
  func registerSettings() {
    guard let path = Bundle(for: AppDelegate.self).path(forResource: "Settings", ofType: "plist"),
      let settings = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
      else {
        fatalError("Couldn't load application settings")
    }
    UserDefaults.standard.register(defaults: settings)
  }

  func registerGMKey() {
    if let key = UserDefaults.standard.string(forKey: UserDefaultKeys.gmKey) {
      log.info("GM registered \(key)")
      GMSServices.provideAPIKey(key)
    }
  }
}
