import 'dart:async';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:stock/home/model/stock_data_model.dart';

class HomeScreenController extends GetxController {
  GetStorage storage = GetStorage();
  bool isResume = false;
  void onPauseResume({required bool val}) {
    val = !val;
    isResume = val;
    update();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  StockData? _stockData;

  StockData? get stockData => _stockData;

  set stockData(StockData? value) {
    _stockData = value;
    update();
  }

  late Timer _timer;
  List<StoredDataModel> storeDataModel = [];

  void updateData({required bool isUpdate}) async {
    if (isUpdate == true) {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        getData();
        update();
      });
    } else {
      _timer.cancel();
      update();
    }
  }

  String maxValueStockName = "";
  List<double> priceData = [];
  //yaha change
  
  void addData() {

    debugPrint("STORED DATA ===>>> ${stockData?.data.length}");
    stockData!.data.forEach((element) {
      priceData.add(element.price);
    });
  
    double a = priceData.reduce((curr, next) => curr > next ? curr : next);
    int ind = stockData!.data.indexWhere((element) => element.price == a);
    maxValueStockName = stockData!.data[ind].sid;
    
    update();
  }

  String url =
      "https://api.tickertape.in/stocks/quotes?sids=TCS,RELI,HDBK,INFY,ITC";
  Future<bool> getData() async {
    try {
      isLoading = true;
      http.Response response = await http.get(Uri.parse(url));
      isLoading = false;
      if (response.statusCode == 200) {
        StockData data = StockData.fromJson(response.body);
        stockData = data;
        if (isResume == true) {
          stockData?.data.forEach((element) {
            debugPrint("ELEMENT ====>>>>> ${element.sid}");
            storeDataModel.add(StoredDataModel(
                rate: element.price,
                date: element.date,
                 change: element.change,
                 close: element.close,
                stockName: element.sid));
            update();
          });
          debugPrint("LENGTH ===>>>> ${storeDataModel.length}");
          storage.writeInMemory("Data", storeDataModel);
        }
        update();
        return true;
      } else {
        update();
        return false;
      }
    } catch (e) {
      update();
      return false;
    }
  }

  @override
  void onInit() {
    getData();
    // TODO: implement onInit
    super.onInit();
  }
}
