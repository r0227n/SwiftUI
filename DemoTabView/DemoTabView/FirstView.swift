//
//  FirstView.swift
//  DemoTabView
//
//  Created by RyoNishimura on 2020/09/26.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationLink(destination: Text("Some detail link")) {
            Text("Go to...")
        }
    }
}
struct SecondView: View {
    var body: some View {
        Text("We are in the SecondView")
    }
}


struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
