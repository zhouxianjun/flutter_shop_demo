import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_demo/constant.dart';
import 'package:flutter_shop_demo/routers.dart';
import 'package:flutter_shop_demo/store/mine/mine.dart';
import 'package:flutter_shop_demo/utils/common.dart' show waitGet;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../components/loading.dart';
import '../config.dart';

class Http {
  static Dio _dio;
  static MineStore _mineStore;

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
          'User-Agent':
              'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1 MicroMessenger/6.5.7 Language/zh_CN'
        },
        connectTimeout: Config.CONNECT_TIMEOUT,
        receiveTimeout: Config.RECEIVE_TIMEOUT);
    Dio dio = new Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions opt) async {
      dio.lock();
      await _checkLock();
      dio.unlock();
      _setHeader(opt);
      _parseRestfulParams(opt);
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
          Routers.router
              .navigateTo(globalContext, Routers.LOGIN, clearStack: true);
          return dio.resolve(e.response);
        }
      }
      _showErrorMsg(e, msg);
      return dio.resolve(e.response ?? {'success': false});
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
    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }

  static void _setHeader(RequestOptions opt) {
    opt.headers['x-wx-openid'] = _mineStore.session.openid;
    opt.headers['x-wx-sign'] = _mineStore.session.sign;
    opt.headers['x-wx-code'] = _mineStore.session.code;
  }

  static _checkLock() async {
    await waitGet((time) {
      if (globalContext != null && _mineStore != null) {
        return true;
      }
      if (globalContext == null) {
        return false;
      }
      try {
        _mineStore = Provider.of<MineStore>(globalContext);
      } catch (e) {
        return false;
      }
      return true;
    });
  }
}

/**
 * 显示错误信息
 */
void _showErrorMsg(DioError e, String msg) {
  if (!e.request.extra.containsKey('showError') ||
      e.request.extra['showError']) {
    Fluttertoast.showToast(
        msg: msg,
        timeInSecForIos: 3,
        backgroundColor: Color.fromRGBO(231, 76, 60, 1),
        textColor: Colors.white);
  }
}

void _closeLoading(extra) {
  bool loading = extra['loading'];
  if (loading != null && loading) {
    Loading.close();
  }
}

/**
 * restful 请求处理: /api/:p, 参数p=1, url则为:/api/1
 */
void _parseRestfulParams(RequestOptions opt) {
  Set<String> remove = new Set();
  opt.queryParameters?.forEach((key, value) {
    if (opt.path.indexOf(key) != -1) {
      opt.path = opt.path.replaceAll(':$key', value.toString());
      remove.add(key);
    }
  });
  opt.queryParameters.removeWhere((key, value) => remove.contains(key));
}
