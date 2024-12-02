import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class GameCenterIdentity {
  GameCenterIdentity({
    required this.publicKeyUrl,
    required this.signature,
    required this.salt,
    required this.timestamp,
    required this.playerId,
  });

  final String publicKeyUrl;
  final String signature;
  final String salt;
  final String timestamp;
  final String playerId;

  @override
  String toString() {
    return 'GameCenterIdentity{publicKeyUrl: $publicKeyUrl, signature: $signature, salt: $salt, timestamp: $timestamp, playerId: $playerId}';
  }
}

class GameCenterHelper {
  static const MethodChannel _channel = MethodChannel('game_center_helper');

  static Future<GameCenterIdentity?> getGameCenterIdentity() async {
    if (!Platform.isIOS) {
      return null;
    }
    try {
      final result = await _channel
          .invokeMethod<Map<dynamic, dynamic>>('getGameCenterIdentity');
      final resultMap = Map<String, String>.from(result!);

      return GameCenterIdentity(
        publicKeyUrl: resultMap['publicKeyUrl']!,
        signature: resultMap['signature']!,
        salt: resultMap['salt']!,
        timestamp: resultMap['timestamp']!,
        playerId: resultMap['playerID']!,
      );
    } catch (e) {
      debugPrint("Error getting Game Center identity: $e");
      return null;
    }
  }
}
