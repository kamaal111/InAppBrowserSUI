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
    @State private var urlToShowInBrowser: URL?

    var body: some View {
        VStack {
            Button(action: { showInAppBrowser = true }) {
                Text("Open browser")
            }
            Button(action: { urlToShowInBrowser = URL(string: "https://kamaal.io") }) {
                Text("Open browser with url")
            }
            Button(action: { urlToShowInBrowser = URL(string: "https://kamaal.io/colorselector") }) {
                Text("Open browser with other url")
            }
        }
        .padding()
        .inAppBrowserSUI(isPresented: $showInAppBrowser, url: URL(string: "https://kamaal.io")!, color: .yellow)
        .inAppBrowserSUI($urlToShowInBrowser, fallbackURL: URL(string: "https://kamaal.io")!, color: .green)
        .accentColor(.red)
        #if os(macOS)
        .frame(minWidth: 300, minHeight: 300)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
