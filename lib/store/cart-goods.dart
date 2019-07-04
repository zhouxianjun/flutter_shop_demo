import 'package:mobx/mobx.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';

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
      unit = map['units'][0];
      units = map['units'];
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
    CartGoods tmp = shoppingCart.data.singleWhere((item) => item.id == id, orElse: () => null);
    quantity = tmp?.quantity ?? 0;
    goodsId = unit['goodsId'];
    canSaleQty = unit['canSaleQty'];
    categoryId = unit['categoryId'];
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
}
