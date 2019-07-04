import 'package:flutter_shop_demo/store/mine/mine.dart';
import 'package:flutter_shop_demo/store/shopping-cart.dart';
import 'package:provider/provider.dart';

final MineStore mineStore = MineStore();
final ShoppingCartStore shoppingCartStore = ShoppingCartStore(mineStore);
List<Provider> _providers;
get providers {
  if (_providers == null) {
    _providers = [
      Provider<MineStore>(builder: (_) => mineStore),
      Provider<ShoppingCartStore>(builder: (_) => shoppingCartStore),
    ];
  }
  return _providers;
}
