import 'package:mobx/mobx.dart';

part 'cart-goods.g.dart';

class CartGoods = _CartGoods with _$CartGoods;

abstract class _CartGoods with Store {
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

  _CartGoods({
    this.title, this.choose, 
    this.name, this.price, 
    this.picture, this.id, 
    this.quantity, this.goodsId,
    this.canSaleQty, this.categoryId
  });

  @action
  void changeQuantity(int quantity) {
    this.quantity = quantity;
  }
}