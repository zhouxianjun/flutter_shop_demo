import 'package:flutter_shop_demo/utils/common.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';

import '../config.dart';

part 'cart-goods.g.dart';

class CartGoods extends _CartGoods {
  final ShoppingCartStore shoppingCart;
  CartGoods(this.shoppingCart) : super(shoppingCart);

  CartGoods.fromJSON(this.shoppingCart, Map map) : super(shoppingCart) {
    Map unit;
    if (map.containsKey('units')) {
      unit = map['units'][0];
      this.parseUnits(map);
    } else {
      unit = map;
    }
    title = map['name'];
    name = unit['name'];
    price = int.parse('${unit['price']}');
    picture = unit['picture'];
    id = int.parse('${unit['id']}');
    CartGoods tmp = shoppingCart.data
        .singleWhere((item) => item.id == id, orElse: () => null);
    quantity = tmp?.quantity ?? 0;
    goodsId = int.parse(unit['goodsId'].toString());
    canSaleQty = int.parse(unit['canSaleQty'].toString());
    categoryId = int.parse(unit['categoryId'].toString());
    imgs = map['imgs'];
    choose = units.isEmpty ? map['choose'] ?? false : units.length > 1;
    detail = map['detail'] ?? '<div/>';
  }

  factory CartGoods.getOrCreate(ShoppingCartStore shoppingCart, Map map) {
    CartGoods tmp = CartGoods.fromJSON(shoppingCart, map);
    CartGoods goods = shoppingCart.data.singleWhere((item) => item.id == tmp.id, orElse: () => tmp).update(tmp);
    return goods;
  }
}

class _CartGoods = __CartGoods with _$_CartGoods;

abstract class __CartGoods with Store {
  final ShoppingCartStore shoppingCart;
  /**
   * 商品名称
   */
  @observable
  String title;
  /**
   * 规格名称
   */
  @observable
  String name;
  /**
   * 规格价格（分）
   */
  @observable
  int price;
  /**
   * 规格图片
   */
  @observable
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
  @observable
  int canSaleQty;
  /**
   * 类别ID
   */
  @observable
  int categoryId;
  /**
   * 图片逗号分隔
   */
  @observable
  String imgs;
  /**
   * 详情富文本
   */
  @observable
  String detail;

  @observable
  bool choose;

  @observable
  ObservableList<CartGoods> units = ObservableList<CartGoods>();

  __CartGoods(this.shoppingCart);

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
    images.addAll(this.units.map((unit) => unit.picture));
    return images.where((img) => img != null && img.trim().isNotEmpty).map((img) => '${Config.IMG_ADDRESS}$img').toSet();
  }

  /**
   * 获取当前规格最大数量
   * 当前规格加入数量 + 可售 - 相同商品的所有已加入数量
   */
  @computed
  int get max {
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

  @action
  CartGoods update(CartGoods newer) {
    if (this == newer) {
      return this;
    }
    this.name = newer.name;
    this.picture = newer.picture;
    this.price = newer.price;
    this.title = newer.title;
    this.canSaleQty = newer.canSaleQty;
    this.categoryId = newer.categoryId;
    this.detail = newer.detail;
    this.imgs = newer.imgs;
    if (newer.units == null || newer.units.isEmpty) {
      this.units.clear();
    } else if (this.units == null || this.units.isEmpty) {
      this.units = newer.units;
    } else {
      this.units.clear();
      this.units.addAll(newer.units.map((item) => this.units.singleWhere((u) => u.id == item.id, orElse: () => item).update(item)));
    }
    return this;
  }

  void parseUnits(Map map) {
    List list = map['units'] as List;
    List<CartGoods> units = list.map((v) {
      v['goodsId'] = map['id'];
      v['canSaleQty'] = map['canSaleQty'];
      v['categoryId'] = map['categoryId'];
      v['choose'] = list.length > 1;
      return CartGoods.getOrCreate(shoppingCart, v);
    }).toList();
    this.units.clear();
    this.units.addAll(units);
    this.units.sort((a, b) => a.price - b.price);
  }
}
