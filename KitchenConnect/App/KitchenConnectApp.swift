//
//  KitchenConnectApp.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import SwiftUI

/// KitchenConnectApp is the entry point of the SwiftUI app.
///
/// This struct conforms to the `App` protocol and defines the main `Scene` to display the `ContentView`.
@main
struct KitchenConnectApp: App {
    /// The body property defines the main `Scene` of the app, which displays the `ContentView` inside a `WindowGroup`.
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
