//
//  ExternalDisplayContent.swift
//  Screens
//
//  Created by Prathamesh Kowarkar on 07/10/20.
//

import Foundation

@Observable class ExternalDisplayContent {
    var string = ""
    var isShowingOnExternalDisplay = false

    var counter = 0

    func increment() {
        counter += 1
    }
}


