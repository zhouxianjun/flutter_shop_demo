// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart-goods.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$_CartGoods on __CartGoods, Store {
  Computed<int> _$maxComputed;

  @override
  int get max => (_$maxComputed ??= Computed<int>(() => super.max)).value;
  Computed<int> _$haveComputed;

  @override
  int get have => (_$haveComputed ??= Computed<int>(() => super.have)).value;

  final _$titleAtom = Atom(name: '__CartGoods.title');

  @override
  String get title {
    _$titleAtom.reportObserved();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.context.checkIfStateModificationsAreAllowed(_$titleAtom);
    super.title = value;
    _$titleAtom.reportChanged();
  }

  final _$nameAtom = Atom(name: '__CartGoods.name');

  @override
  String get name {
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.checkIfStateModificationsAreAllowed(_$nameAtom);
    super.name = value;
    _$nameAtom.reportChanged();
  }

  final _$priceAtom = Atom(name: '__CartGoods.price');

  @override
  int get price {
    _$priceAtom.reportObserved();
    return super.price;
  }

  @override
  set price(int value) {
    _$priceAtom.context.checkIfStateModificationsAreAllowed(_$priceAtom);
    super.price = value;
    _$priceAtom.reportChanged();
  }

  final _$pictureAtom = Atom(name: '__CartGoods.picture');

  @override
  String get picture {
    _$pictureAtom.reportObserved();
    return super.picture;
  }

  @override
  set picture(String value) {
    _$pictureAtom.context.checkIfStateModificationsAreAllowed(_$pictureAtom);
    super.picture = value;
    _$pictureAtom.reportChanged();
  }

  final _$quantityAtom = Atom(name: '__CartGoods.quantity');

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

  final _$canSaleQtyAtom = Atom(name: '__CartGoods.canSaleQty');

  @override
  int get canSaleQty {
    _$canSaleQtyAtom.reportObserved();
    return super.canSaleQty;
  }

  @override
  set canSaleQty(int value) {
    _$canSaleQtyAtom.context
        .checkIfStateModificationsAreAllowed(_$canSaleQtyAtom);
    super.canSaleQty = value;
    _$canSaleQtyAtom.reportChanged();
  }

  final _$categoryIdAtom = Atom(name: '__CartGoods.categoryId');

  @override
  int get categoryId {
    _$categoryIdAtom.reportObserved();
    return super.categoryId;
  }

  @override
  set categoryId(int value) {
    _$categoryIdAtom.context
        .checkIfStateModificationsAreAllowed(_$categoryIdAtom);
    super.categoryId = value;
    _$categoryIdAtom.reportChanged();
  }

  final _$imgsAtom = Atom(name: '__CartGoods.imgs');

  @override
  String get imgs {
    _$imgsAtom.reportObserved();
    return super.imgs;
  }

  @override
  set imgs(String value) {
    _$imgsAtom.context.checkIfStateModificationsAreAllowed(_$imgsAtom);
    super.imgs = value;
    _$imgsAtom.reportChanged();
  }

  final _$detailAtom = Atom(name: '__CartGoods.detail');

  @override
  String get detail {
    _$detailAtom.reportObserved();
    return super.detail;
  }

  @override
  set detail(String value) {
    _$detailAtom.context.checkIfStateModificationsAreAllowed(_$detailAtom);
    super.detail = value;
    _$detailAtom.reportChanged();
  }

  final _$unitsAtom = Atom(name: '__CartGoods.units');

  @override
  ObservableList<CartGoods> get units {
    _$unitsAtom.reportObserved();
    return super.units;
  }

  @override
  set units(ObservableList<CartGoods> value) {
    _$unitsAtom.context.checkIfStateModificationsAreAllowed(_$unitsAtom);
    super.units = value;
    _$unitsAtom.reportChanged();
  }

  final _$__CartGoodsActionController = ActionController(name: '__CartGoods');

  @override
  void changeQuantity(int quantity) {
    final _$actionInfo = _$__CartGoodsActionController.startAction();
    try {
      return super.changeQuantity(quantity);
    } finally {
      _$__CartGoodsActionController.endAction(_$actionInfo);
    }
  }

  @override
  CartGoods update(CartGoods newer) {
    final _$actionInfo = _$__CartGoodsActionController.startAction();
    try {
      return super.update(newer);
    } finally {
      _$__CartGoodsActionController.endAction(_$actionInfo);
    }
  }
}
