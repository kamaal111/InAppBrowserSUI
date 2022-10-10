//
//  InAppBrowserSUI.swift
//
//
//  Created by Kamaal Farah on 24/09/2020.
//

import SwiftUI
import SafariServices

extension View {
    /// On iOS opens the given `URL` in a in app browser when `isPresented` state is set to true and on macOS opens
    /// your default browser with the given `URL`.
    /// - Parameters:
    ///   - isPresented: Whether to open the in app browser or not.
    ///   - url: The url to open in the in app browser.
    ///   - color: The accent color on the browser buttons.
    /// - Returns: The modified view.
    ///
    /// Basic usage example:
    ///
    /// ```swift
    /// import SwiftUI
    /// import InAppBrowserSUI
    ///
    /// struct ContentView: View {
    ///     @State private var showInAppBrowser = false
    ///
    ///     var body: some View {
    ///         Button(action: { showInAppBrowser = true }) {
    ///             Text("Open browser")
    ///         }
    ///         .inAppBrowserSUI(isPresented: $showInAppBrowser, url: URL(string: "https://kamaal.io")!)
    ///     }
    /// }
    /// ```
    public func inAppBrowserSUI(isPresented: Binding<Bool>, url: URL, color: Color = .accentColor) -> some View {
        modifier(InAppBrowserSUI(isPresented: isPresented, url: url, color: color))
    }
}

fileprivate struct InAppBrowserSUI: ViewModifier {
    @Binding var isPresented: Bool

    let url: URL
    let color: Color

    func body(content: Content) -> some View {
        content
            #if canImport(UIKit)
            .sheet(isPresented: $isPresented) {
                InAppBrowserRepresentable(url: url, tintColor: color)
            }
            #else
            .onChange(of: isPresented, perform: { newValue in
                if newValue {
                    NSWorkspace.shared.open(url)
                    isPresented = false
                }
            })
            #endif
    }
}

#if canImport(UIKit)
fileprivate struct InAppBrowserRepresentable: UIViewControllerRepresentable {
    let url: URL
    let tintColor: Color

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let configuaration = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: configuaration)
        safariViewController.dismissButtonStyle = .close
        safariViewController.preferredBarTintColor = .systemBackground
        safariViewController.preferredControlTintColor = UIColor(tintColor)
        return safariViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    typealias UIViewControllerType = SFSafariViewController
}

#if DEBUG
struct InAppBrowserRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        InAppBrowserRepresentable(url: URL(string: "https://kamaal.io")!, tintColor: .red)
    }
}
#endif
#endif
