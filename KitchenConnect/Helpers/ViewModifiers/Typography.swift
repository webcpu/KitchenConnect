//
//  Typography.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import Foundation
import SwiftUI

struct Subtitle1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-SemiBold", size: 16).weight(.bold))
            .lineSpacing(24)
            .foregroundColor(.customCardHeadLine)
    }
}

struct Subtitle2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-SemiBold", size: 14).weight(.bold))
            .lineSpacing(7)
            .foregroundColor(Color.customH4Headline)
    }
}

struct Body2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-SemiBold", size: 14).weight(.bold))
            .lineSpacing(14)
            .foregroundColor(Color.customCardText)
    }
}

struct Button1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("OpenSans-SemiBold", size: 14)
            .weight(.bold))
            .lineSpacing(21)
            .background(Color.customPrimaryCta)
            .foregroundColor(Color.white)
    }
}

struct H1Headline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("ReadexPro-SemiBold", size: 19))
            .lineSpacing(19)
            .foregroundColor(Color.customH4Headline)
    }
}

struct H2Headline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("ReadexPro-SemiBold", size: 25))
            .lineSpacing(34)
            .foregroundColor(Color.customH4Headline)
    }
}

struct H4Headline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("ReadexPro-SemiBold", size: 33))
            .lineSpacing(33)
            .foregroundColor(Color.customH4Headline)
    }
}

extension View {
    func subtitle1() -> some View {
        self.modifier(Subtitle1())
    }
    
    func subtitle2() -> some View {
        self.modifier(Subtitle2())
    }
    
    func body2() -> some View {
        self.modifier(Body2())
    }
    
    func button1() -> some View {
        self.modifier(Button1())
    }
    
    func h1Headline() -> some View {
        self.modifier(H1Headline())
    }
    
    func h2Headline() -> some View {
        self.modifier(H2Headline())
    }
    
    func h4Headline() -> some View {
        self.modifier(H4Headline())
    }
}
