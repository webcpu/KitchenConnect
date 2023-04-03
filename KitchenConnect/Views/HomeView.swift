//
//  HomeView.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import SwiftUI

// MARK: - HomeView

/// A SwiftUI view that represents the home screen, displaying a list of appliances.
struct HomeView: View {
#if DEBUG
    @ObservedObject var iO = injectionObserver
#endif

    @StateObject var viewModel = HomeViewModel(remoteService: RemoteService.shared)

    init() {
        initNavigationBarAppearance()
    }

    var body: some View {
        NavigationView {
            ApplianceListView(viewModel: viewModel)
        }
        .alert(isPresented: $viewModel.isErrorAlertPresented) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.error?.localizedDescription ?? "Unknown error"),
                        dismissButton: .default(Text("OK"))
                    )
                }
        .task {
            viewModel.fetchAppliances()
        }
        .eraseToAnyView()
    }
}

// MARK: - ApplianceListView

/// A SwiftUI view that displays a list of appliances.
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

// MARK: - ApplianceNavigationLink

/// A SwiftUI view that represents a navigation link for an individual appliance.
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

// MARK: - ApplianceCellView

/// A SwiftUI view that represents an individual appliance cell.
struct ApplianceCellView: View {
    var appliance: Appliance

    var body: some View {
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

// MARK: - CustomBackgroundViewModifier

extension View {
    /// Adds a custom background to a SwiftUI view.
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

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
