import 'package:flutter_shop_demo/store/cart-goods.dart';
import 'package:flutter_shop_demo/store/mine/mine.dart';
import 'package:mobx/mobx.dart';

part 'shopping-cart.g.dart';

class ShoppingCartStore = _ShoppingCart with _$ShoppingCartStore;

abstract class _ShoppingCart with Store {
  final MineStore mineStore;

  _ShoppingCart(this.mineStore);

  @observable
  ObservableList<CartGoods> data = ObservableList<CartGoods>();

  @computed
  int get total {
    return this.data.isEmpty
        ? 0
        : this
            .data
            .map((item) => item.quantity)
            .reduce((total, current) => total + current);
  }

  @computed
  int get price {
    return this.data.isEmpty
        ? 0
        : this
            .data
            .map((item) => item.quantity * item.price)
            .reduce((total, current) => total + current);
  }

  @action
  void putIfAbsent(CartGoods goods) {
    if (this.data.contains(goods)) {
      return;
    }
    int index = this.data.indexWhere((item) => item.id == goods.id);
    if (index != -1) {
      this.data[index] = goods;
      return;
    }
    this.data.add(goods);
  }

  @action
  void removeById(int id) {
    this.data.removeWhere((item) => item.id == id);
  }

  @computed
  bool get isAllSpecial {
    return this.data.every(
        (item) => item.categoryId == this.mineStore.specialGoodsCategory);
  }

  @computed
  int get deliveryFee {
    return this.isNeedDeliveryFee ? this.mineStore.deliveryFee : 0;
  }

  @computed
  bool get isNeedDeliveryFee {
    return !this.isAllSpecial &&
        this.mineStore.deliveryFee > 0 &&
        this.price < this.mineStore.freeDelivery;
  }

  @computed
  String get amount {
    return ((this.price + this.deliveryFee) / 100).toStringAsFixed(2);
  }

  @computed
  int get discount {
    return !this.isNeedDeliveryFee ? this.mineStore.deliveryFee : 0;
  }
}
