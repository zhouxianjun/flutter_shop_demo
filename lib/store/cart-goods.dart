import 'package:flutter_shop_demo/utils/common.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';

import '../config.dart';

part 'cart-goods.g.dart';

class CartGoods = _CartGoods with _$CartGoods;

abstract class _CartGoods with Store {
  final ShoppingCartStore shoppingCart;
  /**
   * 商品名称
   */
  String title;
  /**
   * 是否需要选择规格（多个规格）
   */
  bool choose;
  /**
   * 规格名称
   */
  String name;
  /**
   * 规格价格（分）
   */
  int price;
  /**
   * 规格图片
   */
  String picture;
  /**
   * 规格ID
   */
  int id;
  /**
   * 已加入数量
   */
  @observable
  int quantity;
  /**
   * 商品ID
   */
  int goodsId;
  /**
   * 可售数量
   */
  int canSaleQty;
  /**
   * 类别ID
   */
  int categoryId;
  /**
   * 图片逗号分隔
   */
  String imgs;
  List units;

  _CartGoods(this.shoppingCart,
      {this.title,
      this.choose,
      this.name,
      this.price,
      this.picture,
      this.id,
      this.quantity,
      this.goodsId,
      this.canSaleQty,
      this.categoryId,
      this.units});

  _CartGoods.fromJSON(this.shoppingCart, Map map) {
    Map unit;
    if (map.containsKey('units')) {
      this.parseUnits(map);
      unit = this.units[0];
    } else {
      unit = map;
      units = [];
    }
    title = map['name'];
    choose = units.length > 1;
    name = unit['name'];
    price = unit['price'];
    picture = unit['picture'];
    id = unit['id'];
    CartGoods tmp = shoppingCart.data
        .singleWhere((item) => item.id == id, orElse: () => null);
    quantity = tmp?.quantity ?? 0;
    goodsId = unit['goodsId'];
    canSaleQty = unit['canSaleQty'];
    categoryId = unit['categoryId'];
    imgs = map['imgs'];
  }

  bool get isChoose {
    return this.units.length > 1;
  }

  String get pictureUrl {
    return '${Config.IMG_ADDRESS}$picture';
  }

  String get priceFixed {
    return forceMoney(price);
  }

  Set<String> get images {
    List<String> images = [];
    if (this.imgs != null) {
      images.addAll(this.imgs.split(','));
    }
    images.addAll(this.units.map((unit) => unit['picture']));
    return images.where((img) => img != null && img.trim().isNotEmpty).map((img) => '${Config.IMG_ADDRESS}$img').toSet();
  }

  /**
   * 获取当前规格最大数量
   * 当前规格加入数量 + 可售 - 相同商品的所有已加入数量
   */
  @computed
  int get max {
    print('$goodsId -- $have');
    return this.quantity + this.canSaleQty - this.have;
  }

  @computed
  int get have {
    ObservableList list = ObservableList.of(
        this.shoppingCart.data.where((item) => item.goodsId == this.goodsId));
    if (list.isEmpty) {
      return 0;
    }
    return list
        .map((item) => item.quantity)
        .reduce((total, current) => total + current);
  }

  @action
  void changeQuantity(int quantity) {
    this.quantity = quantity;
  }

  void parseUnits(Map map) {
    List units = (map['units'] as List).map((v) {
      v = v as Map;
      v['quantity'] = 0;
      v['id'] = num.parse(v['id']);
      v['price'] = num.parse(v['price']);
      v['goodsId'] = map['id'];
      v['canSaleQty'] = map['canSaleQty'];
      v['categoryId'] = map['categoryId'];
      return v;
    }).toList();
    units.sort((a, b) => a['price'] - b['price']);
    this.units = units;
  }
}
