import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop_demo/components/goods-item.dart';
import 'package:flutter_shop_demo/components/shopping-cart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_shop_demo/routers.dart';
import 'package:flutter_shop_demo/store/cart-goods.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';
import 'package:flutter_shop_demo/utils/common.dart';
import 'package:flutter_shop_demo/utils/http.dart';
import 'package:provider/provider.dart';

const double _ExpandedHeight = 400;

class GoodsDetail extends StatefulWidget {
  final int goodsId;

  GoodsDetail(this.goodsId);

  @override
  State<StatefulWidget> createState() {
    return _GoodsDetailState();
  }
}

class _GoodsDetailState extends State<GoodsDetail>
    with SingleTickerProviderStateMixin {
  ShoppingCartStore shoppingCart;
  ScrollController _scrollController;
  TabController _tabController;
  double y;
  CartGoods cartGoods;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0);
    _tabController = TabController(vsync: this, length: 2);
    y = 0.0;
    _scrollController.addListener(() {
      setState(() {
        y = _scrollController.offset;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    shoppingCart = Provider.of<ShoppingCartStore>(context);
    this.load();
  }

  Future load() async {
    Response<Map> result =
        await Http.dio.get('/api/shop/goods/info/${widget.goodsId}');
    bool success = result.data['success'];
    if (success) {
      Map goods = result.data['value'] as Map;
      collectionForVo(goods, 'unit');
      CartGoods cartGoods = CartGoods.fromJSON(shoppingCart, goods);
      setState(() {
        this.cartGoods = cartGoods;
      });
      // const item = { title: goods.name, choose, ...goods.units[0] };
      // if (!choose) {
      //     const cart = this.shoppingCart.find(v => v.id === goods.units[0].id);
      //     if (cart) {
      //         item.quantity = cart.quantity;
      //     }
      // }
      // this.setState({ goods, item, loaded: true });
    }
  }

  double get frontOpacity {
    final h = _ExpandedHeight * 0.6;
    return this.y > h
        ? 0
        : ((h - this.y) / h).clamp(0.0, 1.0);
  }

  double get backendOpacity {
    return this.frontOpacity >= 1
        ? 0
        : ((this.y > _ExpandedHeight ? _ExpandedHeight : this.y) /
                _ExpandedHeight)
            .clamp(0.0, 1.0);
  }

  List<String> get images {
    return this.cartGoods?.images?.toList() ?? [];
  }

  Widget _renderBack() {
    return Container(
      child: Center(
        child: SizedBox(
          height: 34,
          width: 34,
          child: FlatButton(
            onPressed: () => Routers.router.pop(context),
            color: Color.fromRGBO(0, 0, 0, this.frontOpacity.clamp(0.0, 0.5)),
            shape: CircleBorder(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderTitle() {
    return Opacity(
        opacity: this.backendOpacity,
        child: Center(
          child: SizedBox(
            width: 120,
            child: TabBar(
              labelPadding: EdgeInsets.zero,
              labelColor: Color(0xFFFF6347),
              indicatorColor: Color(0xFFFF6347),
              unselectedLabelColor: Colors.black,
              controller: _tabController,
              tabs: <Widget>[Tab(text: '宝贝'), Tab(text: '详情')],
            ),
          ),
        ));
  }

  List<Widget> _renderActions() {
    return <Widget>[
      FlatButton(
        onPressed: () {},
        padding: EdgeInsets.symmetric(horizontal: 6),
        color: Color.fromRGBO(0, 0, 0, this.frontOpacity.clamp(0.0, 0.5)),
        shape: CircleBorder(),
        child: Icon(
          Icons.shopping_cart,
          size: 22,
        ),
      ),
      FlatButton(
        onPressed: () {},
        padding: EdgeInsets.symmetric(horizontal: 6),
        color: Color.fromRGBO(0, 0, 0, this.frontOpacity.clamp(0.0, 0.5)),
        shape: CircleBorder(),
        child: Icon(
          Icons.more_horiz,
          size: 22,
        ),
      )
    ];
  }

  Widget _renderSwiper() {
    return this.images.isNotEmpty
        ? SafeArea(
            child: Swiper(
                itemBuilder: (_, int index) {
                  return Image.network(this.images[index]);
                },
                itemCount: this.images.length,
                pagination: SwiperPagination()),
          )
        : SizedBox();
  }

  List<Widget> _slivers() {
    return [
      SliverAppBar(
        pinned: true,
        leading: this._renderBack(),
        automaticallyImplyLeading: false,
        title: this._renderTitle(),
        actions: this._renderActions(),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        expandedHeight: _ExpandedHeight,
        flexibleSpace: FlexibleSpaceBar(
          background: this._renderSwiper(),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: GoodsItem(this.cartGoods),
        ),
      ),
      SliverFixedExtentList(
        delegate: SliverChildListDelegate(List.generate(
            16, (int index) => ListTile(title: Text('data - $index')))),
        itemExtent: 60,
      )
    ];
  }

  Widget _body() {
    return EasyRefresh(
      onRefresh: this.load,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: this._slivers(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: ShoppingCart(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
