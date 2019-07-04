// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store-info.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$StoreInfoStore on _StoreInfoStore, Store {
  final _$deliveryFeeAtom = Atom(name: '_StoreInfoStore.deliveryFee');

  @override
  int get deliveryFee {
    _$deliveryFeeAtom.reportObserved();
    return super.deliveryFee;
  }

  @override
  set deliveryFee(int value) {
    _$deliveryFeeAtom.context
        .checkIfStateModificationsAreAllowed(_$deliveryFeeAtom);
    super.deliveryFee = value;
    _$deliveryFeeAtom.reportChanged();
  }

  final _$freeDlvLimitAtom = Atom(name: '_StoreInfoStore.freeDlvLimit');

  @override
  int get freeDlvLimit {
    _$freeDlvLimitAtom.reportObserved();
    return super.freeDlvLimit;
  }

  @override
  set freeDlvLimit(int value) {
    _$freeDlvLimitAtom.context
        .checkIfStateModificationsAreAllowed(_$freeDlvLimitAtom);
    super.freeDlvLimit = value;
    _$freeDlvLimitAtom.reportChanged();
  }
}
