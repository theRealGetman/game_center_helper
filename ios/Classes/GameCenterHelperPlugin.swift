import Flutter
import GameKit
import UIKit

public class GameCenterHelperPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "game_center_helper", binaryMessenger: registrar.messenger())
    let instance = GameCenterHelperPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getGameCenterIdentity" {
      authenticateGameCenter(result: result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func authenticateGameCenter(result: @escaping FlutterResult) {
    let localPlayer = GKLocalPlayer.local

    // Check if the user is authenticated
    if localPlayer.isAuthenticated {
      if #available(iOS 13.5, *) {
        // iOS 13.5 and above: Use fetchItems
        localPlayer.fetchItems(forIdentityVerificationSignature: {
          publicKeyURL, signature, salt, timestamp, error in
          if let error = error {
            result(
              FlutterError(
                code: "GAME_CENTER_ERROR", message: error.localizedDescription, details: nil))
            return
          }

          guard let publicKeyURL = publicKeyURL,
            let signature = signature,
            let salt = salt
          else {
            result(
              FlutterError(
                code: "MISSING_DATA", message: "Missing Game Center data", details: nil))
            return
          }

          result([
            "publicKeyUrl": publicKeyURL.absoluteString,
            "signature": signature.base64EncodedString(),
            "salt": salt.base64EncodedString(),
            "timestamp": String(timestamp),
            "playerID": localPlayer.playerID,
          ])
        })
      } else {
        // iOS versions below 13.5: Use deprecated generateIdentityVerificationSignature
        localPlayer.generateIdentityVerificationSignature {
          publicKeyURL, signature, salt, timestamp, error in
          if let error = error {
            result(
              FlutterError(
                code: "GAME_CENTER_ERROR", message: error.localizedDescription, details: nil))
            return
          }

          guard let publicKeyURL = publicKeyURL,
            let signature = signature,
            let salt = salt
          else {
            result(
              FlutterError(
                code: "MISSING_DATA", message: "Missing Game Center data", details: nil))
            return
          }

          result([
            "publicKeyUrl": publicKeyURL.absoluteString,
            "signature": signature.base64EncodedString(),
            "salt": salt.base64EncodedString(),
            "timestamp": String(timestamp),
            "playerID": localPlayer.playerID,
          ])
        }
      }
    } else {
      // If the player is not authenticated
      result(
        FlutterError(
          code: "NOT_AUTHENTICATED",
          message: "Player is not authenticated",
          details: nil))
    }
  }
}
