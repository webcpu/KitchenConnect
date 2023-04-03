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
        let lightTitleTextColor = Color.customHeroContent?.uiColor ?? UIColor.lightText
        let largeTitleTextColor = Color.customHeroContent?.uiColor ?? UIColor.lightText
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = Color.customBackground?.uiColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: lightTitleTextColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleTextColor]
        coloredAppearance.shadowColor = .clear // This line removes the border

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
}
