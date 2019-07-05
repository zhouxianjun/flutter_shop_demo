import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_demo/components/shopping-cart.dart';
import 'package:flutter_shop_demo/routers.dart';
import '../../constant.dart';
import '../../utils/http.dart';
import 'package:flutter_shop_demo/components/goods-list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List categorys = [];
  int selected = -1;

  @override
  void initState() {
    globalContext = this.context;
    super.initState();
    this._loadCategory();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _loadCategory() async {
    Response<Map<String, dynamic>> res = await Http.dio.get(
        '/api/shop/index/category',
        options: Options(extra: {'loading': true}));
    bool success = res.data['success'];
    if (success) {
      setState(() {
        this.categorys = res.data['value'];
        if (this.categorys != null && this.categorys.length > 0) {
          this.selected = this.categorys[0]['id'];
        }
      });
    }
  }

  Widget _leftDivider() {
    return Container(
      width: 3,
      decoration: BoxDecoration(
        border: Border(
          left: Divider.createBorderSide(context, color: Colors.pink, width: 3),
        ),
      ),
    );
  }

  Widget _renderCategoryItem(Map item) {
    final ThemeData theme = Theme.of(context);
    final isSelected = this.selected == item['id'];
    return InkWell(
      onTap: () {
        setState(() {
          this.selected = item['id'];
        });
      },
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            isSelected ? _leftDivider() : SizedBox(),
            Expanded(
              child: Text(item['name'],
                  textAlign: TextAlign.center,
                  style: theme.textTheme.subhead.merge(
                      isSelected ? TextStyle(color: Colors.pink) : null)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('首页'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              Routers.router.navigateTo(context, Routers.MINE);
            },
          )
        ],
      ),
      floatingActionButton: ShoppingCart(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView(
              children: ListTile.divideTiles(
                  context: context,
                  tiles: this
                      .categorys
                      .map((item) => _renderCategoryItem(item))).toList(),
            ),
          ),
          Expanded(
            flex: 2,
            child: GoodsList(this.selected),
          )
        ],
      ),
    );
  }
}
