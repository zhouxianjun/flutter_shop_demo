import 'package:flutter/material.dart';
import 'package:flutter_shop_demo/constant.dart';
import 'package:flutter_shop_demo/routers.dart';
import 'package:flutter_shop_demo/store/mine/mine.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    globalContext = this.context;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    MineStore store = Provider.of<MineStore>(context);
    await store.loadAuthInfo();
    Routers.router.navigateTo(context, Routers.HOME, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.pink[100]),
      ),
    );
  }
}
