//
//  NavigationButtons.swift
//  KitchenConnect
//
//  Created by liang on 02/04/2023.
//

import SwiftUI

// MARK: - BackButton

struct BackButton: View {
    let title: String
    let action: () -> Void

    init(title: String = "", action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Image("Arrow back")
                    .renderingMode(.template)
                    .foregroundColor(Color.customControlCardIcon)
                Text(title)
                Spacer()
            }
        })
        .padding() // Add padding to increase the tappable area
        .background(Color.clear) // Make the entire area, including the padding, tappable
        .contentShape(Rectangle()) // Ensure the tappable area covers the entire button, including the padding
    }
}

// MARK: - MoreButton
struct MoreButton: View {
    let title: String
    let foregroundColor: Color
    let action: () -> Void

    init(title: String = "", foregroundColor: Color = Color.white, action: @escaping () -> Void) {
        self.title = title
        self.foregroundColor = foregroundColor
        self.action = action
    }

    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Image("Meatball")
                    .renderingMode(.template)
                    .foregroundColor(Color.customControlCardIcon)
                Text(title)
                    .foregroundColor(Color.customCardText)
            }
            .foregroundColor(foregroundColor)
        })
    }
}
