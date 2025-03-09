//
//  ExternalView.swift
//  Screens
//
//  Created by Prathamesh Kowarkar on 07/10/20.
//

import SwiftUI

struct ExternalView: View {

    @Environment(ExternalDisplayContent.self) var externalDisplayContent

    var body: some View {
        VStack {
            Text(externalDisplayContent.string)


            Text("\(externalDisplayContent.counter)")
                .font(.system(size: 96, weight: .bold))
                .contentTransition(.numericText())
                .animation(.default, value: externalDisplayContent.counter)
        }
    }

}

#Preview {
    ExternalView()
        .environment(ExternalDisplayContent())
}
