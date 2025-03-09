//
//  ScreensApp.swift
//  Screens
//
//  Created by Prathamesh Kowarkar on 06/10/20.
//

import SwiftUI
import UIKit
import OSLog

let logger = Logger()

@main
struct ScreensApp: App {

    @State private var externalDisplay = ExternalDisplay()
    @State var externalDisplayContent = ExternalDisplayContent()
    var scene: some UIWindowScene { externalDisplay.scene }

    @State var additionalWindows: [UIWindow] = []

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(externalDisplayContent)
                .onChange(of: externalDisplay.isConnected) {_, isConnected in
                    if isConnected {
                        screenDidConnect()
                    } else {
                        screenDidDisconnect()
                    }
                }
        }
    }

    private func screenDidConnect() {
        // scene.screen.currentMode = scene.screen.availableModes.first { $0.size.width == 720 }
        let window = UIWindow(windowScene: scene)
        let view = ExternalView()
            .environment(externalDisplayContent)
        let controller = UIHostingController(rootView: view)

        window.rootViewController = controller
        window.isHidden = false
        additionalWindows.append(window)
        externalDisplayContent.isShowingOnExternalDisplay = true
    }
   
    private func screenDidDisconnect() {
        additionalWindows.removeAll { $0.screen == scene.windows.first?.screen }
        externalDisplayContent.isShowingOnExternalDisplay = false
    }
}
