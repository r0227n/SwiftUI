//
//  ContentView.swift
//  DemoTabView
//
//  Created by RyoNishimura on 2020/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                FirstView()
                    .tabItem {
                        Text("1")
                    }
                    //.tag(1)
                SecondView()
                    .tabItem {
                        Text("2")
                    }
                    //.tag(2)
            }
            // global, for all child views
            //.navigationBarTitle(Text(navigationBarTitle), displayMode: .inline)
            //.navigationBarHidden(navigationHidden)
            //.navigationBarItems(leading: navigationBarLeadingItems, trailing: navigationBarTrailingItems)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


private extension ContentView {
    var navigationBarTitle: String {
        tabSelection == 1 ? "FirstView" : "SecondView"
    }
    
    var navigationHidden: Bool {
        tabSelection == 2
    }
    @ViewBuilder
    var navigationBarLeadingItems: some View {
        if tabSelection == 1 {
            Text("+")
        }
    }
    @ViewBuilder
    var navigationBarTrailingItems: some View {
        if tabSelection == 1 {
            Text("-")
        }
    }
}
