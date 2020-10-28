//
//  InAppBrowserSUI.swift
//
//
//  Created by Kamaal Farah on 24/09/2020.
//

import SwiftUI
import SafariServices

public extension View {
    func inAppBrowserSUI(isPresented: Binding<Bool>,
                         url: URL,
                         color: UIColor,
                         dismissButtonStyle: SFSafariViewController.DismissButtonStyle = .close) -> some View {
        self.sheet(isPresented: isPresented) {
            InAppBrowserRepresentable(url: url, tintColor: color)
        }
    }
}

internal struct InAppBrowserRepresentable: UIViewControllerRepresentable {
    internal let url: URL
    internal let tintColor: UIColor
    internal let dismissButtonStyle: SFSafariViewController.DismissButtonStyle

    internal init(url: URL,
                  tintColor: UIColor,
                  dismissButtonStyle: SFSafariViewController.DismissButtonStyle = .close) {
        self.url = url
        self.tintColor = tintColor
        self.dismissButtonStyle = dismissButtonStyle
    }

    internal func makeUIViewController(context: Context) -> UIViewControllerType {
        let configuaration = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: configuaration)
        safariViewController.dismissButtonStyle = dismissButtonStyle
        safariViewController.preferredBarTintColor = .systemBackground
        safariViewController.preferredControlTintColor = tintColor
        return safariViewController
    }

    internal func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    internal typealias UIViewControllerType = SFSafariViewController
}

#if DEBUG
struct InAppBrowserRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        InAppBrowserRepresentable(url: URL(string: "https://whatever.com")!, tintColor: .systemRed)
    }
}
#endif
