import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_demo/constant.dart';
import 'package:flutter_shop_demo/routers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../components/loading.dart';
import '../config.dart';

class Http {
  static Dio _dio;

  static Dio get dio {
    if (_dio == null) {
      _dio = _initDio();
    }
    return _dio;
  }

  static Dio _initDio() {
    var options = new BaseOptions(
        baseUrl: Config.BASE_URL,
        headers: {
          'x-wx-openid': 'o_tzEwA3ZqkECZnv0gSxDiMCh86I',
          'x-wx-sign': '6549af63029eff791d1a18d44a8a6027',
          'x-wx-code': '731H0001',
          'User-Agent':
              'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1 MicroMessenger/6.5.7 Language/zh_CN'
        },
        connectTimeout: Config.CONNECT_TIMEOUT,
        receiveTimeout: Config.RECEIVE_TIMEOUT);
    Dio dio = new Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: false));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions opt) {
      // restful 请求处理: /api/:p, 参数p=1, url则为:/api/1
      Set<String> remove = new Set();
      opt.queryParameters?.forEach((key, value) {
        if (opt.path.indexOf(key) != -1) {
          opt.path = opt.path.replaceAll(':$key', value.toString());
          remove.add(key);
        }
      });
      opt.queryParameters.removeWhere((key, value) => remove.contains(key));
      bool loading = opt.extra['loading'];
      if (loading != null && loading) {
        Loading.show();
      }
      return opt;
    }, onResponse: (Response res) {
      if (res.request.responseType == ResponseType.json) {
        if (!res.data['success']) {
          return dio.reject(res.data['message']);
        }
      }
      _closeLoading(res.request.extra);
      return res;
    }, onError: (DioError e) {
      _closeLoading(e.request.extra);
      print('请求错误:' + e.toString());
      String msg = e.message;
      if (e.request.responseType == ResponseType.json && e.response != null) {
        e.response.data['success'] = false;
        msg = e.response.data['message'];
        if (e.response.data['code'] == 99) {
          Routers.router.navigateTo(globalContext, Routers.LOGIN, clearStack: true);
          return dio.resolve(e.response);
        }
      }
      if (!e.request.extra.containsKey('showError') || e.request.extra['showError']) {
        Fluttertoast.showToast(
            msg: msg,
            timeInSecForIos: 3,
            backgroundColor: Color.fromRGBO(231, 76, 60, 1),
            textColor: Colors.white);
      }
      return dio.resolve(e.response);
    }));
    if (Config.PROXY != null) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // config the http client
        client.findProxy = (uri) {
          //proxy all request to localhost:8888
          return "PROXY ${Config.PROXY}";
        };
      };
    }
    return dio;
  }
}

void _closeLoading(extra) {
  bool loading = extra['loading'];
  if (loading != null && loading) {
    Loading.close();
  }
}
