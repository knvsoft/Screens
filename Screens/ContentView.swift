//
//  ContentView.swift
//  Screens
//
//  Created by Prathamesh Kowarkar on 06/10/20.
//

import SwiftUI

struct ContentView: View {

    @Environment(ExternalDisplayContent.self) var externalDisplayContent 

    var body: some View {
        @Bindable var externalDisplayContent = externalDisplayContent

        NavigationView {
            Form {
                if externalDisplayContent.isShowingOnExternalDisplay == false {
                    Section(header: Text("Output")) {
                        Text(externalDisplayContent.string)
                    }
                }
                Section(header: Text("Input")) {
                    TextField("Text", text: $externalDisplayContent.string)
                }

                Button(action: externalDisplayContent.increment) {
                            Text("Increment")
                        }
            }
            .navigationTitle("Screens")
        }
    }

}

#Preview {
    ContentView()
        .environment(ExternalDisplayContent())
}
