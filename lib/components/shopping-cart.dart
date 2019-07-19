import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';
import 'package:flutter_shop_demo/utils/common.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class ShoppingCart extends StatefulWidget {
  static const double HEIGHT = 50.0;

  ShoppingCart({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShoppingCartState();
  }
}

class ShoppingCartState extends State<ShoppingCart> {
  ShoppingCartStore store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.store = Provider.of<ShoppingCartStore>(context);
  }

  Widget _renderPrice() {
    bool haveDelivery = this.store.deliveryFee > 0;
    Widget price = Align(
      alignment: Alignment.center,
      child: Text(
        '¥${this.store.amount}',
        style: TextStyle(
            fontSize: 18,
            color: this.store.total > 0 ? Colors.white : Colors.grey),
      ),
    );
    return haveDelivery
        ? Column(
            children: <Widget>[
              price,
              Row(
                children: <Widget>[
                  Text(
                    '配送费¥${this.store.deliveryFee / 100}',
                    style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                  ),
                  Text('(满¥${forceMoney(this.store.freeDelivery)}免配送费)',
                      style: TextStyle(fontSize: 10, color: Color(0xFF666666))),
                ],
              )
            ],
          )
        : price;
  }

  Widget _renderBadge() {
    bool have = this.store.total > 0;
    Icon icon = Icon(
      Icons.shopping_cart,
      color: this.store.total > 0 ? Colors.yellow : Colors.grey,
      size: 40,
    );
    return have
        ? Badge(
            badgeContent: Text(this.store.total.toString()),
            toAnimate: false,
            child: icon,
          )
        : icon;
  }

  Widget _renderToCart() {
    return MaterialButton(
      onPressed: this.store.total > 0 ? () {} : null,
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: <Widget>[
            Observer(
              builder: (_) => this._renderBadge(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Observer(
                  builder: (_) => this._renderPrice(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderBuy() {
    return MaterialButton(
      onPressed: this.store.total > 0 ? () {} : null,
      color: Color(0xFFCD2626),
      disabledColor: Colors.grey,
      height: ShoppingCart.HEIGHT,
      minWidth: 70,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(30))),
      child: Text(
        '去结算',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Container(
          height: ShoppingCart.HEIGHT,
          color: Color(0xFF2B2B2B),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Observer(
                  builder: (_) => this._renderToCart(),
                ),
              ),
              Observer(
                builder: (_) => this._renderBuy(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
