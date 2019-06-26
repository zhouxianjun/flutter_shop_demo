import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shop_demo/routers.dart';
import 'package:flutter_shop_demo/store/counter.dart';

class Counter1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Counter counter = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('counter测试1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('当前值为:'),
            Observer(
              builder: (_) => Text('${counter.value}'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          child: Text('去C2', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Routers.router.navigateTo(context, Routers.C2);
          },
        )
      ]
    );
  }
}