import 'package:fluro/fluro.dart';
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

  static void configureRoutes(Router router) {
    router.define(LOGIN, handler: Handler(handlerFunc: (context, params) => Login()));
    router.define(HOME, handler: Handler(handlerFunc: (context, params) => Home()));
    router.define(MINE, handler: Handler(handlerFunc: (context, params) => Mine()));
    router.define(C1, handler: Handler(handlerFunc: (context, params) => Counter1()));
    router.define(C2, handler: Handler(handlerFunc: (context, params) => Counter2()));
    Routers.router = router;
  }
}
