import 'package:dio/dio.dart';
import 'package:flutter_shop_demo/store/mine/store-info.dart';
import 'package:flutter_shop_demo/utils/http.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_shop_demo/dto/session.dart';

part 'mine.g.dart';

class MineStore = _MineStore with _$MineStore;

abstract class _MineStore with Store {
  Session session = Session(
      openid: 'o_tzEwA3ZqkECZnv0gSxDiMCh86I',
      sign: '6549af63029eff791d1a18d44a8a6027',
      code: '731H0001');

  @observable
  int specialGoodsCategory = 0;
  @observable
  String nickname = '正在获取...';
  @observable
  StoreInfoStore storeInfoStore;

  @computed
  int get deliveryFee {
    return this.storeInfoStore?.deliveryFee ?? 0;
  }

  @computed
  int get freeDelivery {
    return this.storeInfoStore?.freeDlvLimit ?? 0;
  }

  @action
  loadAuthInfo({force: false}) async {
    Response res =
        await Http.dio.get('/info', queryParameters: {'force': force});
    if (res.data != null && res.data['success']) {
      this.specialGoodsCategory = res.data['data']['specialGoodsCategory'];
      this.nickname = res.data['value']['member']['nickname'];
      this.storeInfoStore = StoreInfoStore.fromJson(res.data['value']['store']);
    }
  }
}
