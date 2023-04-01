//
//  Typography.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import SwiftUI


struct Subtitle2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Open Sans", size: 14).weight(.bold))
            .lineSpacing(7)
            .foregroundColor(Color.customH4Headline)
    }
}

struct Body2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Open Sans", size: 14).weight(.bold))
            .lineSpacing(14)
            .foregroundColor(Color.customCardText)
    }
}

struct H1Headline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Readex Pro SemiBold", size: 19))
            .lineSpacing(19)
            .foregroundColor(Color.customH4Headline)
    }
}

struct H4Headline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Readex Pro SemiBold", size: 33))
            .lineSpacing(33)
            .foregroundColor(Color.customH4Headline)
    }
}

extension View {
    func subtitle2() -> some View {
        self.modifier(Subtitle2())
    }
    
    func body2() -> some View {
        self.modifier(Body2())
    }
    
    func h1Headline() -> some View {
        self.modifier(H1Headline())
    }
    
    func h4Headline() -> some View {
        self.modifier(H4Headline())
    }
}
