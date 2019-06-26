import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop_demo/config.dart';
import 'package:flutter_shop_demo/components/number-input.dart';
import 'package:flutter_shop_demo/utils/common.dart' show forceMoney;

class GoodsItem extends StatefulWidget {
  final dynamic item;
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
  Map get data {
    final bool choose = widget.item['units'].length > 1;
    final Map newer = {'title': widget.item['name'], 'choose': choose};
    newer.addAll(widget.item['units'][0]);
    if (!choose) {
      // const cart = this.shoppingCart.find(v => v.id === item.units[0].id);
      // if (cart) {
      //     newer.quantity = cart.quantity;
      // }
    }
    return newer;
  }

  String get picture {
    final String url = this.data['picture'];
    return '${Config.IMG_ADDRESS}$url';
  }

  String get title {
    return this.data['title'];
  }

  String get name {
    return this.data['name'];
  }

  bool get choose {
    return this.data['choose'];
  }

  String get price {
    return forceMoney(this.data['price']);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                            onPressed: () {},
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
                          NumberInput()
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
