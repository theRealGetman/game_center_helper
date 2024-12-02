# Game Center Helper

A Flutter plugin for integrating with Apple's Game Center. The package simplifies the process of retrieving a user's Game Center identity and provides utilities to manage Game Center authentication within your Flutter app.

## Features

- Retrieve the Game Center identity of the current user.
- Handle platform-specific configurations for Game Center integration.

## Installation

Add the following line to your `pubspec.yaml` file under `dependencies`:

```yaml
dependencies:
  game_center_helper: ^0.1.0
```

Then, run `flutter pub get` to fetch the package.

## Usage

### Import the Package

Import the package into your Dart file:

```dart
import 'package:game_center_helper/game_center_helper.dart';
```

### Retrieve Game Center Identity

Use the `GameCenterHelper.getGameCenterIdentity` method to fetch the Game Center identity of the current user. The method returns a `Future` that resolves to a `Map<String, String>?`, containing user data or `null` if an error occurs.

```dart
Future<void> fetchGameCenterIdentity() async {
  try {
    final gameCenterIdentity = await GameCenterHelper.getGameCenterIdentity();
    if (gameCenterIdentity != null) {
      print('Game Center Identity: $gameCenterIdentity');
    } else {
      print('Failed to retrieve Game Center identity.');
    }
  } catch (e) {
    print('Error: $e');
  }
}
```

### Example Integration

Here's an example of how to integrate Game Center Helper in your app:

```dart
import 'package:flutter/material.dart';
import 'package:game_center_helper/game_center_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Game Center Helper Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final identity = await GameCenterHelper.getGameCenterIdentity();
              if (identity != null) {
                print('Game Center User: $identity');
              } else {
                print('Failed to fetch Game Center identity.');
              }
            },
            child: Text('Get Game Center Identity'),
          ),
        ),
      ),
    );
  }
}
```

## Platform-Specific Setup

### iOS

1. Add the `NSGamesUsageDescription` key to your `Info.plist` file with a description of why your app needs Game Center access:

   ```xml
   <key>NSGamesUsageDescription</key>
   <string>This app requires Game Center access to authenticate users.</string>
   ```

2. Ensure Game Center is enabled in your Xcode project and associated with your app's Apple Developer account.

### Android

Game Center is exclusive to iOS. No additional setup is required for Android, but you may want to add a fallback implementation for Android devices.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on the [GitHub repository](https://github.com/theRealGetman/game_center_helper).

## License

This package is available under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

With `game_center_helper`, integrating Game Center into your Flutter app has never been easier! 🎮
