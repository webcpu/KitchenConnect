//
//  View+NavigationBarAppearance.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import SwiftUI

extension View {
    func initNavigationBarAppearance(foregroundColor: UIColor = UIColor.white) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = Color.customBackground?.uiColor // Change the color to your desired light gray
        coloredAppearance.titleTextAttributes = [.foregroundColor: Color.customHeroContent!.uiColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: Color.customHeroContent!.uiColor]
        coloredAppearance.shadowColor = .clear // This line removes the border
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
}
