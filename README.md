# Places App
## Architecture
* Application has been developed with MVVM-C pattern. I have not used SwiftUI `NavigationStack` consciously as `NavigationStack` keeps View and Navigation tightly coupled whereas coordinator pattern decouples it and handles it efficiently at this moment in IMHO.

## Network layer
* In network layer you will see the use of protocol oriented approach to create services.
* Encapsulated all types of errors into single Network layer consumer (application) friendly error type `DataError`.
* Introduced parser which will have more of an application specific data processing.

## Views
* `@Observable` macro have not been used as app should support current OS and previous 2 OS as a standard practice.

## Testing
* Snapshot tests have been used as an alternative for UITests. Of course XCUITests can be used to add E2ETests to improve test coverage.
* If `AddLocationViewModelTests` fails please make sure that Xcode and Simulator has same locale.
* LocationsGetService has also been manually test by disabling caching along with Proxyman tool to inject various mock responses.
