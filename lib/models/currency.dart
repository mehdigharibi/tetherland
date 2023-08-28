// ignore_for_file: camel_case_types

class USDT {
  int? price;
  String? diff24d;
  String? diff7d;
  String? diff30d;
  int? last24h;
  int? last24hMin;
  int? last24hMax;
  int? last7d;
  int? last7dMin;
  int? last7dMax;
  int? last30d;
  int? last30dMin;
  int? last30dMax;

  USDT(
      {required this.price,
      required this.diff24d,
      required this.diff7d,
      required this.diff30d,
      required this.last24h,
      required this.last24hMin,
      required this.last24hMax,
      required this.last7d,
      required this.last7dMin,
      required this.last7dMax,
      required this.last30d,
      required this.last30dMin,
      required this.last30dMax});

  USDT.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    diff24d = json['diff24d'];
    diff7d = json['diff7d'];
    diff30d = json['diff30d'];
    last24h = json['last24h'];
    last24hMin = json['last24hMin'];
    last24hMax = json['last24hMax'];
    last7d = json['last7d'];
    last7dMin = json['last7dMin'];
    last7dMax = json['last7dMax'];
    last30d = json['last30d'];
    last30dMin = json['last30dMin'];
    last30dMax = json['last30dMax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['diff24d'] = this.diff24d;
    data['diff7d'] = this.diff7d;
    data['diff30d'] = this.diff30d;
    data['last24h'] = this.last24h;
    data['last24hMin'] = this.last24hMin;
    data['last24hMax'] = this.last24hMax;
    data['last7d'] = this.last7d;
    data['last7dMin'] = this.last7dMin;
    data['last7dMax'] = this.last7dMax;
    data['last30d'] = this.last30d;
    data['last30dMin'] = this.last30dMin;
    data['last30dMax'] = this.last30dMax;
    return data;
  }
}
