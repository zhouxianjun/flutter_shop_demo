// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping-cart.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$ShoppingCartStore on _ShoppingCart, Store {
  Computed<int> _$totalComputed;

  @override
  int get total => (_$totalComputed ??= Computed<int>(() => super.total)).value;
  Computed<int> _$priceComputed;

  @override
  int get price => (_$priceComputed ??= Computed<int>(() => super.price)).value;
  Computed<bool> _$isAllSpecialComputed;

  @override
  bool get isAllSpecial =>
      (_$isAllSpecialComputed ??= Computed<bool>(() => super.isAllSpecial))
          .value;
  Computed<int> _$deliveryFeeComputed;

  @override
  int get deliveryFee =>
      (_$deliveryFeeComputed ??= Computed<int>(() => super.deliveryFee)).value;
  Computed<bool> _$isNeedDeliveryFeeComputed;

  @override
  bool get isNeedDeliveryFee => (_$isNeedDeliveryFeeComputed ??=
          Computed<bool>(() => super.isNeedDeliveryFee))
      .value;
  Computed<String> _$amountComputed;

  @override
  String get amount =>
      (_$amountComputed ??= Computed<String>(() => super.amount)).value;
  Computed<int> _$discountComputed;

  @override
  int get discount =>
      (_$discountComputed ??= Computed<int>(() => super.discount)).value;

  final _$dataAtom = Atom(name: '_ShoppingCart.data');

  @override
  ObservableList<CartGoods> get data {
    _$dataAtom.reportObserved();
    return super.data;
  }

  @override
  set data(ObservableList<CartGoods> value) {
    _$dataAtom.context.checkIfStateModificationsAreAllowed(_$dataAtom);
    super.data = value;
    _$dataAtom.reportChanged();
  }

  final _$_ShoppingCartActionController =
      ActionController(name: '_ShoppingCart');

  @override
  void putIfAbsent(CartGoods goods) {
    final _$actionInfo = _$_ShoppingCartActionController.startAction();
    try {
      return super.putIfAbsent(goods);
    } finally {
      _$_ShoppingCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeById(int id) {
    final _$actionInfo = _$_ShoppingCartActionController.startAction();
    try {
      return super.removeById(id);
    } finally {
      _$_ShoppingCartActionController.endAction(_$actionInfo);
    }
  }
}
