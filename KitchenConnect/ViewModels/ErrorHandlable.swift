//
//  ErrorHandlable.swift
//  KitchenConnect
//
//  Created by liang on 03/04/2023.
//

import Foundation

/// A protocol for view models that handle errors.
///
/// The `ErrorHandlable` protocol defines a set of properties and methods that view models can implement
/// to handle errors and display appropriate error messages to the user. Conforming view models must
/// implement these properties and methods to handle errors and provide error information to the UI.
///
/// The `ObservableObject` protocol is also conformed to, which allows properties to be observed for
/// changes and notify the view when changes occur.
protocol ErrorHandlable: ObservableObject {
    /// The error that occurred, or `nil` if no error has occurred.
    var error: Error? { get set }

    /// A boolean flag indicating whether an error alert view is currently presented to the user.
    var isErrorAlertPresented: Bool { get set }

    /// Shows an error message to the user.
    ///
    /// Implementing view models must provide a method to show an error message to the user. This method
    /// should update the `error` property with the given error parameter, and set the
    /// `isErrorAlertPresented` property to `true` to trigger the presentation of an error alert view in
    /// the UI.
    ///
    /// - Parameter error: The error to display to the user.
    func showError(error: Error)
}
