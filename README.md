# KitchenConnect

The project follows the MVVM architecture pattern and uses dependency injection to facilitate communication between classes. The project has the following classes, protocols, and structs:

## Views

### HomeView

`HomeView` is a struct that displays a list of appliances fetched by `HomeViewModel`.

### RemoteControlView

`RemoteControlView` is a struct that displays the remote control for a single appliance managed by `RemoteControlViewModel`.

## ViewModels

### HomeViewModel

`HomeViewModel` is a class responsible for fetching appliances from the remote service and managing the list of appliances. It uses the `RemoteService` class to interact with the remote service.

### RemoteControlViewModel

`RemoteControlViewModel` is a class that manages the state of the remote control for an appliance. It uses the `RemoteService` class to interact with the remote service.

## Models

### Appliance

`Appliance` is a struct representing a home appliance.

## Services

### RemoteService

`RemoteService` is a class that communicates with a remote service to manage appliances. It implements the `RemoteServiceProtocol` protocol.

## Protocols

### RemoteServiceProtocol

`RemoteServiceProtocol` is a protocol defining the methods required for a remote service. It is implemented by the `RemoteService` class.

Overall, the project uses MVVM architecture to separate concerns and facilitate testability. Dependency injection is used to allow for flexibility in the implementation of the remote service.
