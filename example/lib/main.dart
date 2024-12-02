import 'package:flutter/material.dart';
import 'package:game_center_helper/game_center_helper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Game Center Helper Example'),
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
            child: const Text('Get Game Center Identity'),
          ),
        ),
      ),
    );
  }
}
