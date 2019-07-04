// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart-goods.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$CartGoods on _CartGoods, Store {
  Computed<int> _$maxComputed;

  @override
  int get max => (_$maxComputed ??= Computed<int>(() => super.max)).value;
  Computed<int> _$haveComputed;

  @override
  int get have => (_$haveComputed ??= Computed<int>(() => super.have)).value;

  final _$quantityAtom = Atom(name: '_CartGoods.quantity');

  @override
  int get quantity {
    _$quantityAtom.reportObserved();
    return super.quantity;
  }

  @override
  set quantity(int value) {
    _$quantityAtom.context.checkIfStateModificationsAreAllowed(_$quantityAtom);
    super.quantity = value;
    _$quantityAtom.reportChanged();
  }

  final _$_CartGoodsActionController = ActionController(name: '_CartGoods');

  @override
  void changeQuantity(int quantity) {
    final _$actionInfo = _$_CartGoodsActionController.startAction();
    try {
      return super.changeQuantity(quantity);
    } finally {
      _$_CartGoodsActionController.endAction(_$actionInfo);
    }
  }
}
