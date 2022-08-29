import 'package:meta/meta.dart';
import 'dart:convert';

class StockData {
  bool success;
  List<Datum> data;
  StockData({required this.success, required this.data});
}

class Datum {
  Datum({
    required this.sid,
    required this.price,
    required this.close,
    required this.change,
    required this.high,
    required this.low,
    required this.volume,
    required this.date,
  });
  String sid;
  double price;
  double close;
  double change;
  double high;
  double low;
  int volume;
  DateTime date;

  Datum copyWith({
    String? sid,
    double? price,
    double? close,
    double? change,
    double? high,
    double? low,
    int? volume,
    DateTime? date,
  }) =>
      Datum(
        sid: sid ?? this.sid,
        price: price ?? this.price,
        close: close ?? this.close,
        change: change ?? this.change,
        high: high ?? this.high,
        low: low ?? this.low,
        volume: volume ?? this.volume,
        date: date ?? this.date,
      );
  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        sid: json["sid"] == null ? null : json["sid"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        close: json["close"] == null ? null : json["close"].toDouble(),
        change: json["change"] == null ? null : json["change"].toDouble(),
        high: json["high"] == null ? null : json["high"].toDouble(),
        low: json["low"] == null ? null : json["low"].toDouble(),
        volume: json["volume"] == null ? null : json["volume"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "sid": sid == null ? null : sid,
        "price": price == null ? null : price,
        "close": close == null ? null : close,
        "change": change == null ? null : change,
        "high": high == null ? null : high,
        "low": low == null ? null : low,
        "volume": volume == null ? null : volume,
        "date": date == null ? null : date.toIso8601String(),
      };
}

class StoredDataModel {
  StoredDataModel(
      {required this.rate, required this.date, required this.stockName});
  double rate;
  DateTime date;
  String stockName;
  StoredDataModel copyWith({
    required double rate,
    required DateTime date,
    required String Stockname,
  }) =>
      StoredDataModel(rate: rate, date: date, stockName: stockName);
  factory StoredDataModel.fromJson(String str) =>
      StoredDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoredDataModel.fromMap(Map<String, dynamic> json) => StoredDataModel(
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        date: DateTime.parse(json["date"]),
        stockName: json["stockName"] == null ? null : json["stockName"],
      );

  Map<String, dynamic> toMap() => {
        "rate": rate == null ? null : rate,
        "date": date == null ? null : date.toIso8601String(),
        "stockName": stockName == null ? null : stockName,
      };
}
