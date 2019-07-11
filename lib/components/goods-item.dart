import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shop_demo/components/choose-unit.dart';
import 'package:flutter_shop_demo/config.dart';
import 'package:flutter_shop_demo/components/number-input.dart';
import 'package:flutter_shop_demo/routers.dart';
import 'package:flutter_shop_demo/store/cart-goods.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';
import 'package:flutter_shop_demo/utils/common.dart' show forceMoney;
import 'package:provider/provider.dart';

class GoodsItem extends StatefulWidget {
  final CartGoods item;
  final VoidCallback onChoose;
  final bool edit;

  const GoodsItem(this.item, {this.onChoose, this.edit = true, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoodsItemState();
  }
}

class _GoodsItemState extends State<GoodsItem> {
  ShoppingCartStore shoppingCart;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    shoppingCart = Provider.of<ShoppingCartStore>(context);
  }

  String get picture {
    final String url = this.widget.item.picture;
    return '${Config.IMG_ADDRESS}$url';
  }

  String get title {
    return this.widget.item.title;
  }

  String get name {
    return this.widget.item.name;
  }

  bool get choose {
    return this.widget.item.choose;
  }

  String get price {
    return forceMoney(this.widget.item.price);
  }

  void changeHandler(int newer, int old) {
    shoppingCart.putIfAbsent(this.widget.item);
    this.widget.item.changeQuantity(newer);
  }

  void chooseHandler() {
    showDialog(
        context: context,
        builder: (BuildContext _) {
          return ChooseUnit(this.widget.item);
        });
  }

  Widget get renderAdd {
    return Observer(
      builder: (_) {
        return this.widget.item.quantity > 0
            ? NumberInput(
                value: this.widget.item.quantity,
                min: 0,
                max: this.widget.item.max,
                onChange: this.changeHandler,
              )
            : FlatButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    Text(
                      '加入购物车',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                color: Color(0xFFFF4081),
                textColor: Colors.white,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                onPressed: () {
                  this.changeHandler(1, 0);
                },
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Routers.router.navigateTo(context, '/detail/${this.widget.item.goodsId}'),
      child: Row(
        children: <Widget>[
          Image.network(this.picture,
              width: 60, height: 60, fit: BoxFit.contain),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(this.title,
                        style: TextStyle(fontSize: 14, color: Colors.black))),
                this.choose
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('¥$price',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.red[300])),
                          FlatButton(
                            color: Colors.red[300],
                            textColor: Colors.white,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            onPressed: this.chooseHandler,
                            child: Text('选规格', style: TextStyle(fontSize: 11)),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(this.name,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                              Text('¥$price',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red[300]))
                            ],
                          ),
                          this.renderAdd
                        ],
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
