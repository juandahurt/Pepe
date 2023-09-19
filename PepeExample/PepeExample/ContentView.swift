//
//  ContentView.swift
//  PepeExample
//
//  Created by Juan Hurtado on 19/09/23.
//

import SwiftUI
import Pepe

struct ContentView: View {
    @EnvironmentObject var observer: ObserverExample
    @EnvironmentObject var appState: AppState
    
    @State var message: String = "Hello!"
    
    var timeModifierRow: some View {
        Toggle("Time", isOn: $appState.timeEnabled)
    }
    
    var levelModifierRow: some View {
        Toggle("Level", isOn: $appState.levelEnabled)
    }

    var pepeModifierRow: some View {
        Toggle("Pepe", isOn: $appState.pepeEnabled)
    }
    
    var fileModifierRow: some View {
        Toggle("File", isOn: $appState.fileEnabled)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Color.clear.frame(height: 1)
            List {
                Section("Logs") {
                    ForEach(0..<observer.logs.count, id: \.self) { index in
                        Text(observer.logs[index].message)
                            .font(.footnote)
                    }
                }
            }.listStyle(.plain)
            
            List {
                Section("Modifiers") {
                    pepeModifierRow
                    levelModifierRow
                    timeModifierRow
                    fileModifierRow
                }
            }
            
            HStack {
                TextField("Message", text: $message)
                    .textFieldStyle(.plain)
                Button {
                    appState.logger.log(message)
                } label: {
                    Text("Log")
                }
                .buttonStyle(.borderedProminent)
            }.padding()
        }
    }
}
