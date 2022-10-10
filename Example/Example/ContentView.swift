//
//  ContentView.swift
//  Example
//
//  Created by Kamaal M Farah on 10/10/2022.
//

import SwiftUI
import InAppBrowserSUI

struct ContentView: View {
    @State private var showInAppBrowser = false

    var body: some View {
        VStack {
            Button(action: { showInAppBrowser = true }) {
                Text("Open browser")
            }
        }
        .padding()
        .inAppBrowserSUI(isPresented: $showInAppBrowser, url: URL(string: "https://kamaal.io")!, color: .systemGreen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
