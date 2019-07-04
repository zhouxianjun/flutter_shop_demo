import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'views/home/index.dart';
import './routers.dart';
import 'package:flutter_shop_demo/store/index.dart';

void main() => runApp(MultiProvider(
      providers: providers,
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  MyApp() {
    final Router router = new Router();
    Routers.configureRoutes(router);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonTheme: ButtonThemeData(
              minWidth: 0,
              height: 0,
              padding: EdgeInsets.zero,
              buttonColor: Colors.transparent)),
      home: Home(),
      onGenerateRoute: Routers.router.generator,
      navigatorObservers: [RouterObserver()],
    );
  }
}

class RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
  }
}
