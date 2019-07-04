import 'package:dio/dio.dart';
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

  loadAuthInfo({force: false}) async {
    Response<Map> res =
        await Http.dio.get('/info', queryParameters: {'force': force});
    if (res.data != null && res.data['success']) {
      print(res.data['value']);
    }

    // if (result.success) {
    //     this.member = result.value;
    //     this.specialGoodsCategory = result.data.specialGoodsCategory;
    //     return this.member;
    // }
    return null;
  }
}
