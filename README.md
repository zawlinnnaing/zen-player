# Zen Player

Zen Player is a distraction-free player for streaming youtube and others. 
(Currently only supports **youtube**). It is available in **android**, **ios**, **web** and **windows**.

Available Features:
- Disables Recommended section
- Provides analytics on watch time
- Allows timer
- Allows searching by both urls and names
- Allows queueing and looping of videos


## Development

Prerequisites:
- Flutter v2.0.4
- For developing for desktop, checkout [flutter desktop support](https://flutter.dev/desktop).

Steps:

- Install dependencies

```shell
flutter pub get
```

- Run app (must have one emulator enabled)

```shell
flutter run --trace-systrace --no-sound-null-safety -d <EMULATOR-DEVICE-ID>
```

- Tests

```shell
flutter test
```

You can checkout coding standard for this project [here](docs/coding_standard.md).
