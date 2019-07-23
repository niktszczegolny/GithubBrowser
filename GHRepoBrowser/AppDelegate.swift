//
//  AppDelegate.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

/*
Wymagania biznesowe:
Zbudować na platformie iOS wyszukiwarkę repozytoriów z użyciem publicznego API Github (developer.github.com/v3/). W oparciu o podaną nazwę aplikacja powinna wyświetlać listę pasujących repozytoriów. Po kliknięciu w dane repozytorium powinniśmy przejść do jego szczegółów (nazwa, thumbnail oraz potencjalnie inne “przydatne informacje” - ilość informacji oraz ich sposób prezentacji pozostawiamy w gestii programisty). Inne, dodatkowe funkcje pozostawiamy do decyzji programisty.

Wymagania techniczne:
Rozwiązanie powinno zostać dostarczone jako kompletny projekt Xcode napisany w Objective-C lub Swift, bez użycia designera graficznego ekranów (bez Storyboardów albo XIB), w postaci repozytorium git możliwego do sklonowania.
Dopuszczalne jest używanie zewnętrznych zależności (np. Pods).
Aplikacja powinna uruchamiać się na symulatorze oraz jednym, dowolnie wybranym przez programistę modelu iPhone'a.
*/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: Coordinating = AppCoordinator.default

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // apply appearance
        AppAppearance.apply()

        // start the app
        coordinator.start()
        
        return true
    }

}

