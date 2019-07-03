import 'dart:math' show min;

/**
 * vo中的字符串分隔值转为集合
 * {'goodsNames': 'a,b', 'goodsPrice': '1,2'} = {'goods': [{'name': 'a', 'price': 1}, {'name': 'b', 'price': 2}]}
 */
void collectionForVo(vo, String prefix, [name]) {
  if (vo is List) {
    vo.forEach((v) => collectionForVo(v, prefix));
  } else if (vo is Map<String, dynamic>) {
    Map<String, List<String>> map = {};
    int minLength = 0;
    vo.keys.where((String key) => key.startsWith(prefix) && key.endsWith('s')).forEach((key) {
      String newerKey = key.substring(prefix.length, key.length - 1);
      newerKey = '${newerKey.substring(0, 1).toLowerCase()}${newerKey.substring(1)}';
      List<String> val = vo[key].toString().split(',');
      map[newerKey] = val;
      minLength = minLength == 0 ? val.length : min(minLength, val.length);
    });
    vo[name ?? '${prefix}s'] = List<Map<String, dynamic>>.generate(minLength, (index) {
      Map<String, dynamic> obj = {};
      map.forEach((key, val) => obj[key] = val[index]);
      return obj;
    });
  }
}

/**
 * 强制小数位 例4.5 => 4.50; 1 => 1.00; 1.123 => 1.12
 * @param {Number | String} val 源数字
 * @param {Number} count 小数位数
 */
String forceDecimal(num val, { count = 2 }) {
    final String str = val.toString();
    final List<String> list = str.split('.');
    final String start = list[0];
    final String end = list.length > 1 ? list[1] : '';
    String v = end.length > count ? end.substring(0, count) : end.padRight(count, '0');
    return '$start.$v';
}

String forceMoney(num money) {
  return forceDecimal(money / 100);
}