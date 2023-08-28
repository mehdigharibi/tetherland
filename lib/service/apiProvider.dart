import 'package:flutter/material.dart';
import 'package:tetherlandclone/models/currencies.dart';
import 'package:tetherlandclone/models/currency.dart';

import 'currencyService.dart';

class apiProvider extends ChangeNotifier {
  TextEditingController usdt = TextEditingController();
  TextEditingController toman = TextEditingController();

  int? tomanValue;
  String? currentUsdtPrice = '0';
  USDT usdtModel = USDT(
      price: 0,
      diff24d: '0',
      diff7d: '0',
      diff30d: '0',
      last24h: 0,
      last24hMin: 0,
      last24hMax: 0,
      last7d: 0,
      last7dMin: 0,
      last7dMax: 0,
      last30d: 0,
      last30dMin: 0,
      last30dMax: 0);

  List<currencies?> currenciesModel = [];

  Future<int> calculateToman() async {
    return await getCurrency() as int;
  }

  Future<USDT?> calculateUSDTmodel() async {
    return await getCurrencyModel() as USDT;
  }

  Future<List<currencies>?> fetchcurrencies() async {
    print('Runnnnn');

    return await getCurrenciesData();
  }
}
