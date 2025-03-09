//
//  ExternalDisplay.swift
//  Screens
//
//  Observe connections

import Foundation

#if canImport(UIKit)
import UIKit
#endif

@Observable class ExternalDisplay {
    var isConnected: Bool = false
    var scene: UIWindowScene!

    private var willConnectObserver: NSObjectProtocol?
    private var didDisconnectObserver: NSObjectProtocol?

    init() {
        addObservers()
    }

    deinit {
        let center = NotificationCenter.default
        if let observer = self.willConnectObserver {
            center.removeObserver(observer)
        }
        if let observer = self.didDisconnectObserver {
            center.removeObserver(observer)
        }
    }
}

extension ExternalDisplay {

    func addObservers() {
        let center = NotificationCenter.default

        willConnectObserver = center.addObserver(
            forName: UIScene.willConnectNotification,
            object: nil,
            queue: .main)
        { [weak self] notification in
            if let scene = notification.object as? UIWindowScene,
               scene.session.role == .windowExternalDisplayNonInteractive
            {
                logger.info("Screen connected: \(scene.session.configuration.name ?? "Unknown")")
                self?.scene = scene
                self?.isConnected = true
            }
        }

        didDisconnectObserver = center.addObserver(
            forName: UIScene.didDisconnectNotification,
            object: nil,
            queue: .main)
        { [weak self] notification in
            if let scene = notification.object as? UIWindowScene,
               scene.session.role == .windowExternalDisplayNonInteractive
            {
                logger.info("Screen disconnected: \(scene.session.configuration.name ?? "Unknown")")
                self?.scene = scene
                self?.isConnected = false
            }
        }
    }
}
