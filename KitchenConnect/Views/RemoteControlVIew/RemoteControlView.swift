//
//  RemoteControlView.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import SwiftUI

// MARK: - RemoteControlView

/// A view that displays the remote control for an appliance.
///
/// This view displays a header showing the name and state of the appliance, as well as a set of controls
/// for adjusting the appliance's settings. It also includes a switch button for turning the appliance on or off.
struct RemoteControlView: View {
    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif

    /// The presentation mode for the view.
    @Environment(\.presentationMode) var presentationMode

    /// The view model for the remote control.
    @StateObject var viewModel: RemoteControlViewModel

    /// Initializes a new instance of the view with the specified appliance.
    ///
    /// - Parameter appliance: The appliance to control.
    init(appliance: Appliance) {
        let value = RemoteControlViewModel(appliance: appliance, remoteService: RemoteService.shared)
        _viewModel = StateObject(wrappedValue: value)
    }

    var body: some View {
        VStack {
            Spacer()

            // Display the control header view
            ControlHeaderView(viewModel: viewModel)

            Spacer()

            // Display the control view
            ControlsView(viewModel: viewModel)

            Spacer()

            // Display the switch button for turning the appliance on or off
            SwitchButton(text: viewModel.appliance.state == "Off" ? "TURN ON" : "TURN OFF", action: viewModel.toggleApplianceState)

            Spacer()
        }

        .withDefaultPadding()
        .withCustomBackground()
        .withNavigationBar(
            leading: BackButton {
                presentationMode.wrappedValue.dismiss()
            },
            trailing: MoreButton {
                // Do something
            }
        )
        .withErrorAlert(error: viewModel.error, isPresented: $viewModel.isErrorAlertPresented)
        .eraseToAnyView()
    }
}

// MARK: - RemoteControlView Helpers

fileprivate extension View {
    /// Adds default horizontal padding to the view.
    func withDefaultPadding() -> some View {
        self.padding(.horizontal, 16)
    }

    /// Adds a custom background color to the view.
    func withCustomBackground() -> some View {
        self.background(Color.customBackground)
    }

    /// Adds a navigation bar to the view with the specified leading and trailing items.
    ///
    /// - Parameters:
    ///   - leading: The leading item to display in the navigation bar.
    ///   - trailing: The trailing item to display in the navigation bar.
    func withNavigationBar<Leading: View, Trailing: View>(
        leading: Leading,
        trailing: Trailing
    ) -> some View {
        self.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: leading, trailing: trailing)
    }

    /// Displays an error alert when an error occurs.
    ///
    /// - Parameters:
    ///   - error: The error to display in the alert view.
    ///   - isPresented: A binding to a Boolean value that determines whether the alert is displayed.
    func withErrorAlert(error: Error?, isPresented: Binding<Bool>) -> some View {
        self.alert(isPresented: isPresented) {
            Alert(
                title: Text("Error"),
                message: Text(error?.localizedDescription ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - ControlHeaderView

/// A view that displays the header for a remote control.
///
/// This view shows the name and state of the appliance being controlled, as well as an icon
/// representing the type of appliance.
struct ControlHeaderView: View {
    /// The view model for the remote control.
    @ObservedObject var viewModel: RemoteControlViewModel

    /// Initializes a new instance of the view with the specified view model.
    ///
    /// - Parameter viewModel: The view model for the remote control.
    init(viewModel: RemoteControlViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(alignment: .top) {
            VStack {
                // Display the name of the appliance
                Text(viewModel.appliance.name)
                    .subtitle2()
                    .foregroundColor(Color.customHeroContent)

                // Display the state of the appliance
                Text(viewModel.appliance.state)
                    .h2Headline()
                    .accessibility(identifier: "remote-control-appliance-\(viewModel.appliance.applianceId)")
            }
            .padding(.leading, 8)

            // Display an icon representing the type of appliance
            Spacer()
            Image("Oven").padding(.trailing, -100)
        }
    }
}

// MARK: - ControlsView

/// A view that displays the controls for a remote control.
///
/// This view shows two `ControlView` views side by side. Each `ControlView` represents a different
/// function of the remote control, such as setting the temperature or selecting a program.
struct ControlsView: View {
    /// The view model for the remote control.
    @ObservedObject var viewModel: RemoteControlViewModel

    /// Initializes a new instance of the view with the specified view model.
    ///
    /// - Parameter viewModel: The view model for the remote control.
    init(viewModel: RemoteControlViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                // Display the title of the controls view
                Text("Controls")
                    .subtitle1()
                    .foregroundColor(Color.customHeadLineTitle)
                Spacer()
            }

            HStack(spacing: 16) {
                // Display the program control view
                ControlView(appliance: viewModel.appliance, imageName: programName, description: "Function", data: programName)

                // Display the temperature control view
                ControlView(appliance: viewModel.appliance, imageName: "Temperature", description: "Temperature", data: displayTemperatureWithUnit)
            }
        }
    }

    var programName: String {
        viewModel.appliance.program.rawValue.capitalized
    }

    var displayTemperatureWithUnit: String {
        viewModel.appliance.displayTemperatureWithUnit
    }
}

// MARK: - ControlView

struct ControlView: View {
    let appliance: Appliance
    let imageName: String
    let description: String
    let data: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(imageName)
                    .padding(16)
                Spacer()
            }
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(description)
                        .body2()
                    Text(data)
                        .subtitle1()
                }.padding(16)
                Spacer()
            }
        }
        .cornerRadius(8)
        .background(Color.white)
        .frame(height: 119)
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
    }
}

// MARK: - SwitchButton

struct SwitchButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .modifier(PrimaryButtonStyle())
        }
        .padding(.horizontal, 75)
    }
}

// MARK: - PrimaryButtonStyle

struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .button1()
            .cornerRadius(40)
            .contentShape(Rectangle())
    }
}

// struct RemoteControlView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemoteControlView(appliance: Appliance())
//    }
// }
