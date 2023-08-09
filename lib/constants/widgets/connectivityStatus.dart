import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

void showConnectivitySnackBar(ConnectivityResult result) {
  final hasInternet = result != ConnectivityResult.none;
  final message = hasInternet
      ? 'Connected, syncing'
      : 'You are offline. Connect to internet, to sync your location';
  final color = hasInternet ? Colors.green : Colors.red;

  Utils.showTopSnackBar(message, color);
}

class Utils {
  static void showTopSnackBar(
    String message,
    Color color,
  ) =>
      showSimpleNotification(
        Text(
          'Internet Connectivity Update',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'poppins',
          ),
        ),
        subtitle: Text(
          message,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'mont',
          ),
        ),
        background: color,
        duration: Duration(seconds: 2),
        slideDismiss: true,
        autoDismiss: true,
        position: NotificationPosition.top,
        leading: SizedBox.fromSize(
          size: const Size(40, 40),
          child: Icon(
            Icons.network_check,
            size: 25,
          ),
        ),
      );
}
