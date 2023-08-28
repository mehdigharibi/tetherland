import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tetherlandclone/models/currencies.dart';

import '../models/currency.dart';

Future<int?> getCurrency() async {
  USDT usdtprice;

  String apiUrl = 'https://api.tetherland.com/currencies';

  var response = await http.get(
    Uri.parse(apiUrl),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    usdtprice = USDT.fromJson(data['data']['currencies']['USDT']);

    return usdtprice.price;
  } else {
    print('API request failed with status code ${response.statusCode}');
  }
}

Future<USDT?> getCurrencyModel() async {
  USDT usdtprice;

  String apiUrl = 'https://api.tetherland.com/currencies';

  var response = await http.get(
    Uri.parse(apiUrl),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    usdtprice = USDT.fromJson(data['data']['currencies']['USDT']);

    return usdtprice;
  } else {
    print('API request failed with status code ${response.statusCode}');
  }
}

Future<List<currencies>?> getCurrenciesData() async {
  List<currencies> currenciesList = [];

  String apiUrl = 'https://service.tetherland.com/api/v5/currencies';

  var response = await http.get(
    Uri.parse(apiUrl),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];

    // print(temp.faName);

    for (var i = 0; i <= 10; i++) {
      currencies? temp;
      temp = currencies.fromJson(data[i]);
      if (i != 1) {
        currenciesList.add(temp);
      }
    }
    //print(currenciesList[1]);
    return currenciesList;
  } else {
    print('API request failed with status code ${response.statusCode}');
  }
}
