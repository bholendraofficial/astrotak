import 'package:astrotak/app/application.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHelper {
  static void hideKeyBoard(BuildContext context) {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  static Future<bool> checkInternetConnectivity() async {
    String connectionStatus;
    bool isConnected = false;
    final Connectivity _connectivity = Connectivity();

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
      if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.mobile) {
        if (kDebugMode) {
          print("===internetconnected==Mobile" + connectionStatus);
        }
        isConnected = true;
        // I am connected to a mobile network.
      } else if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.wifi) {
        isConnected = true;
        if (kDebugMode) {
          print("===internetconnected==wifi" + connectionStatus);
        }
        // I am connected to a wifi network.
      } else if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.none) {
        isConnected = false;
        if (kDebugMode) {
          print("===internetconnected==not" + connectionStatus);
        }
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("===internet==not connected" + e.toString());
      }
      connectionStatus = 'Failed to get connectivity.';
    }
    return isConnected;
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  static void showSnackBarMessage(String message) {
    if (message != null && message.isNotEmpty) {
      Application.scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message.toString(),
        ),
      ));
    }
  }
}
