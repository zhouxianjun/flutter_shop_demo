import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constant.dart';

bool _status = false;

class Loading {
  static void show([text = '加载中...']) {
    if (_status) {
      return;
    }
    _status = true;
    showDialog(
      context: globalContext,
      builder: (ctx) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitDoubleBounce(color: Colors.blue),
                Text(text, style: TextStyle(color: Colors.blue, fontSize: 18))
              ],
            ),
          ),
        );
      }
    );
  }

  static void close() {
    _status = false;
    Navigator.of(globalContext, rootNavigator: true).pop();
  }
}