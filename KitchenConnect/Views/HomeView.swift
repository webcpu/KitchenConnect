//
//  HomeView.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import SwiftUI

struct HomeView: View {
#if DEBUG
    @ObservedObject var iO = injectionObserver
#endif
    
    @StateObject var viewModel = HomeViewModel()
    
    init() {
        initNavigationBarAppearance()
    }
    
    var body: some View {
        NavigationView {
            ApplianceListView(viewModel: viewModel)
        }
        .task {
            viewModel.fetchAppliances()
        }
        .eraseToAnyView()
    }
}

struct ApplianceListView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.appliances.values, id: \.applianceId) { appliance in
                    ApplianceNavigationLink(appliance: appliance)
                }
            }
        }
        .customBackground()
        .navigationTitle("Home")
    }
}

struct ApplianceNavigationLink: View {
    let appliance: Appliance
    
    var body: some View {
        NavigationLink(destination: RemoteControlView(appliance: appliance)) {
            ApplianceCellView(appliance: appliance)
                .padding(.horizontal, 16)
            
        }
        .accessibility(identifier: "appliance-\(appliance.applianceId)")
    }
}

struct ApplianceCellView : View {
    var appliance: Appliance
    
    var body: some View {
        //Card - Home Product
        VStack(spacing: 0) {
            Text(appliance.name)
                .subtitle2()
                .padding(.top, 24)
                .accessibility(identifier: "applianceName")
            
            Image("Oven")
                .resizable()
                .scaledToFill()
                .padding(.top, 24)
                .padding(.horizontal, 72)
            
            VStack(spacing: 8) {
                Text(appliance.state)
                    .h4Headline()
                Text("Tap to select function.")
                    .body2()
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: 295)
        }
        .frame(height: 392)
        .padding(.horizontal, 48)
        .background(Color.customCardBackground)
        .cornerRadius(8)
    }
}

extension View {
    func customBackground() -> some View {
        self.modifier(CustomBackgroundViewModifier())
    }
}

struct CustomBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .edgesIgnoringSafeArea(.all)
            .padding(.top, 16)
            .background(Color.customBackground)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

