//
//  TestNaviApp.swift
//  TestNavi
//
//  Created by RyoNishimura on 2020/09/18.
//

import SwiftUI

@main
struct TestNaviApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
