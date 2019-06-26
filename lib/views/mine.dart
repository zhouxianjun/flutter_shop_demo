import 'package:flutter/material.dart';

class Mine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的')),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(color: Colors.pink[400], height: 200),
              Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          child: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/images/my.jpeg'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Alone',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 2,
              separatorBuilder: (context, i) {
                return const Divider(indent: 70);
              },
              itemBuilder: (context, i) {
                return ListTile(
                  // leading: CircleAvatar(backgroundImage: NetworkImage('https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png'),),
                  leading: Icon(Icons.list, size: 36,),
                  title: Text('订单列表-$i'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
