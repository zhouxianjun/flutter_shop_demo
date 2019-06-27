import 'package:flutter_shop_demo/store/cart-goods.dart';
import 'package:mobx/mobx.dart';

part 'shopping-cart.g.dart';

class ShoppingCart = _ShoppingCart with _$ShoppingCart;

abstract class _ShoppingCart with Store {
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

  // @computed get isAllSpecial {
  //     const { specialGoodsCategory } = UserStore;
  //     return this.data.every(item => item.categoryId === specialGoodsCategory);
  // }

  // @computed get deliveryFee () {
  //     const { deliveryFee } = UserStore;
  //     return this.isNeedDeliveryFee ? deliveryFee : 0;
  // }

  // @computed get isNeedDeliveryFee () {
  //     const { deliveryFee, freeDelivery } = UserStore;
  //     return !this.isAllSpecial && deliveryFee > 0 && this.price < freeDelivery;
  // }

  // @computed get amount () {
  //     return ((this.price + this.deliveryFee) / 100).toFixed(2);
  // }

  // @computed get discount () {
  //     const { deliveryFee } = UserStore;
  //     return !this.isNeedDeliveryFee ? deliveryFee : 0;
  // }
}
