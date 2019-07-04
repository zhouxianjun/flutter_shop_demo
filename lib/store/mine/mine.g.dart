// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mine.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$MineStore on _MineStore, Store {
  Computed<int> _$deliveryFeeComputed;

  @override
  int get deliveryFee =>
      (_$deliveryFeeComputed ??= Computed<int>(() => super.deliveryFee)).value;
  Computed<int> _$freeDeliveryComputed;

  @override
  int get freeDelivery =>
      (_$freeDeliveryComputed ??= Computed<int>(() => super.freeDelivery))
          .value;

  final _$specialGoodsCategoryAtom =
      Atom(name: '_MineStore.specialGoodsCategory');

  @override
  int get specialGoodsCategory {
    _$specialGoodsCategoryAtom.reportObserved();
    return super.specialGoodsCategory;
  }

  @override
  set specialGoodsCategory(int value) {
    _$specialGoodsCategoryAtom.context
        .checkIfStateModificationsAreAllowed(_$specialGoodsCategoryAtom);
    super.specialGoodsCategory = value;
    _$specialGoodsCategoryAtom.reportChanged();
  }

  final _$nicknameAtom = Atom(name: '_MineStore.nickname');

  @override
  String get nickname {
    _$nicknameAtom.reportObserved();
    return super.nickname;
  }

  @override
  set nickname(String value) {
    _$nicknameAtom.context.checkIfStateModificationsAreAllowed(_$nicknameAtom);
    super.nickname = value;
    _$nicknameAtom.reportChanged();
  }

  final _$storeInfoStoreAtom = Atom(name: '_MineStore.storeInfoStore');

  @override
  StoreInfoStore get storeInfoStore {
    _$storeInfoStoreAtom.reportObserved();
    return super.storeInfoStore;
  }

  @override
  set storeInfoStore(StoreInfoStore value) {
    _$storeInfoStoreAtom.context
        .checkIfStateModificationsAreAllowed(_$storeInfoStoreAtom);
    super.storeInfoStore = value;
    _$storeInfoStoreAtom.reportChanged();
  }

  final _$loadAuthInfoAsyncAction = AsyncAction('loadAuthInfo');

  @override
  Future loadAuthInfo({dynamic force = false}) {
    return _$loadAuthInfoAsyncAction
        .run(() => super.loadAuthInfo(force: force));
  }
}
