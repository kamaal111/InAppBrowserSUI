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
    ///   - isPresented: Whether to open the browser or not.
    ///   - url: The url to open in the browser.
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
        modifier(InAppBrowserSUI(
            isPresented: isPresented,
            url: .constant(url),
            fallbackURL: url,
            color: color,
            bindingWithURL: false))
    }

    /// On iOS opens the given `URL` in a in app browser when `isPresented` state is set to true and on macOS opens
    /// your default browser with the given `URL`.
    /// - Parameters:
    ///   - url: The url to show. If this url is not nil than the browser opens.
    ///   - fallbackURL: A valid url in case the url given is invalid.
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
    ///     @State private var urlToShowInBrowser: URL?
    ///
    ///     var body: some View {
    ///         Button(action: { urlToShowInBrowser = URL(string: "https://kamaal.io") }) {
    ///             Text("Open browser")
    ///         }
    ///         .inAppBrowserSUI($urlToShowInBrowser, fallbackURL: URL(string: "https://kamaal.io")!)
    ///     }
    /// }
    /// ```
    public func inAppBrowserSUI(_ url: Binding<URL?>, fallbackURL: URL, color: Color = .accentColor) -> some View {
        return modifier(InAppBrowserSUI(
            isPresented: .constant(url.wrappedValue != nil),
            url: url,
            fallbackURL: fallbackURL,
            color: color,
            bindingWithURL: true))
    }
}

fileprivate struct InAppBrowserSUI: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var url: URL?

    let fallbackURL: URL
    let color: Color
    let bindingWithURL: Bool

    func body(content: Content) -> some View {
        content
            #if canImport(UIKit)
            .sheet(isPresented: $isPresented, onDismiss: {
                if bindingWithURL {
                    url = nil
                }
            }) {
                InAppBrowserRepresentable(url: url ?? fallbackURL, tintColor: color)
            }
            #else
            .onChange(of: isPresented, perform: { newValue in
                if !bindingWithURL, newValue, let url {
                    NSWorkspace.shared.open(url)
                    isPresented = false
                }
            })
            .onChange(of: url, perform: { newValue in
                if bindingWithURL, let url = newValue {
                    NSWorkspace.shared.open(url)
                    self.url = nil
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
