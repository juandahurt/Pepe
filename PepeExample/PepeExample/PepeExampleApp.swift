//
//  PepeExampleApp.swift
//  PepeExample
//
//  Created by Juan Hurtado on 19/09/23.
//


import SwiftUI
import Pepe

@main
struct PepeExampleApp: App {
    var appState = AppState()
    let observer = ObserverExample()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(observer)
                .environmentObject(appState)
                .onAppear {
                    appState.logger.observer = observer
                }
        }
    }
}

class ObserverExample: LoggerObserver, ObservableObject {
    @Published var logs: [Log] = []
    
    func willLog(log: Log) {
        logs.insert(log, at: 0)
    }
}

class AppState: ObservableObject {
    @Published var logger: PepeLogger = Pepe.loggerPlease()
    @Published var timeEnabled = false {
        didSet {
            updateModifiers()
        }
    }
    @Published var levelEnabled = false {
        didSet {
            updateModifiers()
        }
    }
    @Published var fileEnabled = false {
        didSet {
            updateModifiers()
        }
    }
    @Published var pepeEnabled = true {
        didSet {
            updateModifiers()
        }
    }
    
    init() {
        logger.modifiers = [.pepe]
        logger.writer = .os(subsystem: "subsystem", category: "category")
    }
    
    private func updateModifiers() {
        logger.modifiers = []
        if pepeEnabled { logger.modifiers.append(.pepe) }
        if levelEnabled { logger.modifiers.append(.level) }
        if timeEnabled { logger.modifiers.append(.time) }
        if fileEnabled { logger.modifiers.append(.file.withLine()) }
    }
}
