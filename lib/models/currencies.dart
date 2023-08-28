import 'dart:convert';

class currencies {
  String? name;
  String? faName;
  String? logo;
  String? accentColor;
  String? symbol;
  String? price;
  double? tomanAmount;
  String? minUsdtValue;
  int? minUsdtAmount;
  int? maxUsdtAmount;
  String? minValue;
  String? maxAmount;
  int? minIrrAmount;
  int? maxIrrAmount;
  int? priority;
  int? priceRoundDigit;
  int? amountRoundDigit;
  double? changes24h;
  double? changes7d;
  int? trendy;
  String? exchange;

  String? createdAt;

  currencies(
      {required this.name,
      required this.faName,
      required this.logo,
      required this.accentColor,
      required this.symbol,
      required this.price,
      required this.tomanAmount,
      required this.minUsdtValue,
      required this.minUsdtAmount,
      required this.maxUsdtAmount,
      required this.minValue,
      required this.maxAmount,
      required this.minIrrAmount,
      required this.maxIrrAmount,
      required this.priority,
      required this.priceRoundDigit,
      required this.amountRoundDigit,
      required this.changes24h,
      required this.changes7d,
      required this.trendy,
      required this.exchange,
      required this.createdAt});

  currencies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    faName = json['fa_name'];
    logo = json['logo'];
    accentColor = json['accent_color'];
    symbol = json['symbol'];
    price = json['price'];
    tomanAmount = json['toman_amount'];
    minUsdtValue = json['min_usdt_value'];
    minUsdtAmount = json['min_usdt_amount'];
    maxUsdtAmount = json['max_usdt_amount'];
    minValue = json['min_value'];
    maxAmount = json['max_amount'];
    minIrrAmount = json['min_irr_amount'];
    maxIrrAmount = json['max_irr_amount'];
    priority = json['priority'];
    priceRoundDigit = json['price_round_digit'];
    amountRoundDigit = json['amount_round_digit'];
    changes24h = json['changes_24h'];
    changes7d = json['changes_7d'];
    trendy = json['trendy'];
    exchange = json['exchange'];

    createdAt = json['createdAt'];
  }
}
