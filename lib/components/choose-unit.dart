import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shop_demo/components/number-input.dart';
import 'package:flutter_shop_demo/config.dart';
import 'package:flutter_shop_demo/store/cart-goods.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';
import 'package:flutter_shop_demo/utils/common.dart';
import 'package:provider/provider.dart';

class ChooseUnit extends StatefulWidget {
  final CartGoods goods;

  const ChooseUnit(this.goods, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChooseUnitState();
  }
}

class _ChooseUnitState extends State<ChooseUnit> {
  ShoppingCart shoppingCart;
  CartGoods unit;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    shoppingCart = Provider.of<ShoppingCart>(context);
    unit = shoppingCart.data.firstWhere(
        (item) =>
            item.goodsId == this.widget.goods.goodsId && item.quantity > 0,
        orElse: () {
      return CartGoods.fromJSON(shoppingCart, this.widget.goods.units[0]);
    });
  }

  List get units {
    return this.widget.goods.units;
  }

  String get picture {
    String url = this.unit.picture;
    return '${Config.IMG_ADDRESS}$url';
  }

  String get price {
    return forceMoney(this.unit.price);
  }

  void changeHandler(int newer, int old) {
    shoppingCart.putIfAbsent(this.unit);
    this.unit.changeQuantity(newer);
  }

  Widget get renderAdd {
    return Observer(
      builder: (_) {
        return this.unit.quantity > 0
            ? NumberInput(
                value: this.unit.quantity,
                min: 0,
                max: this.unit.max,
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
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                onPressed: () {
                  this.changeHandler(1, 0);
                },
              );
      },
    );
  }

  List<Widget> get choiceUnits {
    return this
        .units
        .map((map) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(map['name']),
                selected: this.unit.id == map['id'],
                onSelected: (val) {
                  setState(() {
                    this.unit = this.shoppingCart.data.singleWhere(
                        (item) => item.id == map['id'],
                        orElse: () => CartGoods.fromJSON(shoppingCart, map));
                  });
                },
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(widget.goods.title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.network(this.picture,
                            width: 80, height: 80, fit: BoxFit.contain),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(this.unit.name))
                      ],
                    ),
                    Text(this.price,
                        style:
                            TextStyle(color: Color(0xFFDC143C), fontSize: 16))
                  ],
                ),
                Row(
                  children: this.choiceUnits,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Color(0xFFEEEEEE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text('数量'), this.renderAdd],
            ),
          )
        ],
      ),
    );
  }
}
