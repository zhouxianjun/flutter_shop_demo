import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter_shop_demo/views/detail.dart';
import 'views/login.dart';
import 'views/home/index.dart';
import 'views/mine.dart';
import 'package:flutter_shop_demo/views/counter1.dart';
import 'package:flutter_shop_demo/views/counter2.dart';

class Routers {
  static Router router;

  static const String LOGIN = '/login';
  static const String HOME = '/home';
  static const String MINE = '/member';
  static const String C1 = '/c1';
  static const String C2 = '/c2';
  static const String DETAIL = '/detail';

  static void configureRoutes(Router router) {
    router.define(LOGIN, handler: Handler(handlerFunc: (context, params) => Login()));
    router.define(HOME, handler: Handler(handlerFunc: (context, params) => Home()));
    router.define(MINE, handler: Handler(handlerFunc: (context, params) => Mine()));
    router.define(C1, handler: Handler(handlerFunc: (context, params) => Counter1()));
    router.define(C2, handler: Handler(handlerFunc: (context, params) => Counter2()));
    router.define(DETAIL, handler: Handler(handlerFunc: (context, params) => GoodsDetail()));
    Routers.router = router;
  }

  static String encode(String value) {
    StringBuffer sb = StringBuffer();
    List<int> encoded = Utf8Encoder().convert(value);
    encoded.forEach((val) => sb.write('$val,'));
    return sb.toString().substring(0, sb.length - 1).toString();
  }

  static String decode(String value) {
    List<String> decoded = value.split('[').last.split(']').first.split(',');
    List<int> list = decoded.map((s) => int.parse(s.trim()));
    return Utf8Decoder().convert(list);
  }
}
