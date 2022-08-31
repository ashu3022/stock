// import 'package:meta/meta.dart';
// import 'dart:convert';

// class StockData {
//   bool success;
//   List<Datum> data;
//   StockData({required this.success, required this.data});
// }

// class Datum {
//   Datum({
//     required this.sid,
//     required this.price,
//     required this.close,
//     required this.change,
//     required this.high,
//     required this.low,
//     required this.volume,
//     required this.date,
//   });
//   String sid;
//   double price;
//   double close;
//   double change;
//   double high;
//   double low;
//   int volume;
//   DateTime date;

//   Datum copyWith({
//     String? sid,
//     double? price,
//     double? close,
//     double? change,
//     double? high,
//     double? low,
//     int? volume,
//     DateTime? date,
//   }) =>
//       Datum(
//         sid: sid ?? this.sid,
//         price: price ?? this.price,
//         close: close ?? this.close,
//         change: change ?? this.change,
//         high: high ?? this.high,
//         low: low ?? this.low,
//         volume: volume ?? this.volume,
//         date: date ?? this.date,
//       );
//   factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Datum.fromMap(Map<String, dynamic> json) => Datum(
//         sid: json["sid"] == null ? null : json["sid"],
//         price: json["price"] == null ? null : json["price"].toDouble(),
//         close: json["close"] == null ? null : json["close"].toDouble(),
//         change: json["change"] == null ? null : json["change"].toDouble(),
//         high: json["high"] == null ? null : json["high"].toDouble(),
//         low: json["low"] == null ? null : json["low"].toDouble(),
//         volume: json["volume"] == null ? null : json["volume"],
//         date: DateTime.parse(json["date"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "sid": sid == null ? null : sid,
//         "price": price == null ? null : price,
//         "close": close == null ? null : close,
//         "change": change == null ? null : change,
//         "high": high == null ? null : high,
//         "low": low == null ? null : low,
//         "volume": volume == null ? null : volume,
//         "date": date == null ? null : date.toIso8601String(),
//       };
// }

// class StoredDataModel {
//   StoredDataModel(
//       {required this.rate, required this.date, required this.stockName});
//   double rate;
//   DateTime date;
//   String stockName;
//   StoredDataModel copyWith({
//     required double rate,
//     required DateTime date,
//     required String Stockname,
//   }) =>
//       StoredDataModel(rate: rate, date: date, stockName: stockName);
//   factory StoredDataModel.fromJson(String str) =>
//       StoredDataModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory StoredDataModel.fromMap(Map<String, dynamic> json) => StoredDataModel(
//         rate: json["rate"] == null ? null : json["rate"].toDouble(),
//         date: DateTime.parse(json["date"]),
//         stockName: json["stockName"] == null ? null : json["stockName"],
//       );

//   Map<String, dynamic> toMap() => {
//         "rate": rate == null ? null : rate,
//         "date": date == null ? null : date.toIso8601String(),
//         "stockName": stockName == null ? null : stockName,
//       };
// }
// To parse this JSON data, do
//
//     final stockData = stockDataFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class StockData {
  StockData({
    required this.success,
    required this.data,
  });

  bool success;
  List<Datum> data;

  StockData copyWith({
    required bool success,
    required List<Datum> data,
  }) =>
      StockData(
        success: success,
        data: data,
      );

  factory StockData.fromJson(String str) => StockData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StockData.fromMap(Map<String, dynamic> json) => StockData(
        success: json["success"] == null ? null : json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
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
// To parse this JSON data, do
//
//     final storedDataModel = storedDataModelFromMap(jsonString);

class StoredDataModel {
  StoredDataModel({
    required this.rate,
    required this.change,
    required this.close,
    required this.date,
    required this.stockName,
  });

  double rate;
  DateTime date;
  double change;
  double close;
  String stockName;

  StoredDataModel copyWith({
    required double rate,
    required double close,
    required double change,
    required DateTime date,
    required String stockName,
  }) =>
      StoredDataModel(
        rate: rate,
        date: date,
        change: change,
        close: close,
        stockName: stockName,
      );

  factory StoredDataModel.fromJson(String str) =>
      StoredDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoredDataModel.fromMap(Map<String, dynamic> json) => StoredDataModel(
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        close: json["close"] == null ? null : json["close"].toDouble(),
        change: json["change"] == null ? null : json["change"].toDouble(),
        date: DateTime.parse(json["date"]),
        stockName: json["stockName"] == null ? null : json["stockName"],
      );

  Map<String, dynamic> toMap() => {
        "rate": rate == null ? null : rate,
        "close":close == null ? null : close,
        "change":change == null ? null : change,
        "date": date == null ? null : date.toIso8601String(),
        "stockName": stockName == null ? null : stockName,
      };
}
