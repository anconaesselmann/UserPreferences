# UserPreferences

UserPreferences is an alternative to SwiftUI's @AppStorage

## Author

Axel Ancona Esselmann, axel@anconaesselmann.com

## License

UserPreferences is available under the MIT license. See the LICENSE file for more info.


## Motivation

SwiftUI's `@AppStorage` property wrapper is a convenient way to utilize `UserDefaults`. Sadly all `View`s that utilize `@AppStorage` will receive a refresh whenever any `@AppStorage` property is updated. `UserPreferences` is a small library that allows quick access to `UserPreferences` with granular `View` updates.

## [Example 1](https://github.com/anconaesselmann/UserPreferences/tree/main/Examples/Example_01):

We define a preference-key-enum:

```swift
enum ExampleKey: String, UserPreferenceKey {
    case aIsOn, bIsOn
}
```

We inject our user preference store implementation into the view environment:

```swift
@main
struct Example_01App: App {

    @StateObject
    var preferences = UserPreferences<ExampleKey>()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(preferences)
        }
    }
}
```

by default `UserDefaults` is used to store preferences. Custom stores can be injected into the `UserPreferences` initializer.

We can now read preferences:

```swift
struct SomeView: View {

    @UserPreference(ExampleKey.aIsOn)
    var aIsOn: Bool = false

    var body: some View {
        Text(aIsOn ? "On" : "Off")
    }
}
```

and write preferences:

```swift
struct AnotherView: View {

    @UserPreference(ExampleKey.aIsOn)
    var aIsOn: Bool = false

    var body: some View {
        Toggle(
            "Set aIsOn",
            isOn: $aIsOn
        )
    }
}
```

Only views that toggle or read from `aIsOn` will update if `aIsOn` changes.
