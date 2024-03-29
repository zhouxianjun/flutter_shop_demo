import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop_demo/store/cart-goods.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';
import 'package:flutter_shop_demo/utils/http.dart';
import 'package:flutter_shop_demo/utils/common.dart' show collectionForVo;
import 'package:flutter_shop_demo/components/goods-item.dart';
import 'package:provider/provider.dart';

class GoodsList extends StatefulWidget {
  final int category;

  const GoodsList(this.category, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoodsListState();
  }
}

class _GoodsListState extends State<GoodsList> {
  int pageNum = 1;
  int pageSize = 10;
  List<CartGoods> list = [];
  ValueNotifier<int> categoryWatch = ValueNotifier(-1);
  ShoppingCartStore shoppingCart;

  @override
  void initState() {
    super.initState();
    categoryWatch.addListener(() {
      print('分类改变了: ${categoryWatch.value}');
      this.refresh();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    shoppingCart = Provider.of<ShoppingCartStore>(context);
  }

  @override
  void dispose() {
    categoryWatch.dispose();
    super.dispose();
  }

  chooseHandler() {}

  refresh() {
    return this.pull(force: true);
  }

  pull({bool force = false}) async {
    if (force) {
      this.pageNum = 1;
      setState(() {
        this.list.clear();
      });
    }
    Response<Map<String, dynamic>> res = await Http.dio.get(
        '/api/shop/index/goods',
        queryParameters: {
          'category': widget.category,
          'pageNum': this.pageNum,
          'pageSize': this.pageSize
        },
        options: Options(extra: {'loading': true}));
    if (res.data != null && res.data['success']) {
      final List data = res.data['value']['list'] ?? [];
      collectionForVo(data, 'unit');
      final List<CartGoods> goodsList = data.map((item) => CartGoods.getOrCreate(shoppingCart, item)).toList();
      setState(() {
        this.pageNum++;
        this.list.addAll(goodsList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    categoryWatch.value = widget.category;
    return EasyRefresh(
      onRefresh: () {
        return this.refresh();
      },
      child: ListView.separated(
        itemCount: this.list.length,
        separatorBuilder: (_, i) {
          return Divider();
        },
        itemBuilder: (_, i) {
          return GoodsItem(this.list[i], onChoose: this.chooseHandler);
        },
      ),
    );
  }
}
