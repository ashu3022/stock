import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock/home/model/stock_data_model.dart';

class GraphScreenController extends GetxController {
  GetStorage storage = GetStorage();
  List<StoredDataModel> storeDataModel = [];
  getData() {
    storeDataModel = storage.read("Data");
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  List<StoredDataModel> filteredData = [];
  List<double> priceList = [];
  List<DateTime> dateList = [];
  filterData({required String name}) {
    storeDataModel.forEach((element) {
      if (element.stockName == name) {
        filteredData.add(StoredDataModel(
            date: element.date,
            rate: element.rate,
            stockName: element.stockName));
        priceList.add(element.rate);
        dateList.add(element.date);
        update();
      }
    });
  }
}

// List<StoreDataModel> data = [
//   StoreDataModel(rate: 13, time:0,stockName: ""),
//   StoreDataModel(rate: 10, time:5,stockName: "" ),
//   StoreDataModel(rate: 15, time:10,stockName: "" ),
//   StoreDataModel(rate:12 , time:15,stockName: "" ),
//   StoreDataModel(rate: 11, time:20,stockName: "" ),
//   StoreDataModel(rate: 5, time:25,stockName: "" ),
//   StoreDataModel(rate: 15, time:30,stockName: "" ),
//   StoreDataModel(rate: 19, time:35,stockName: "" ),
//   StoreDataModel(rate: 8, time:40,stockName: "" ),
//   StoreDataModel(rate: 16, time:45,stockName: "" ),
// ];
// class ModelWithStockName{
//   String stockName;
//   List<StoreDataModel> data;
//   ModelWithStockName({required this.stockName,required this.data});
// }
class StoreDataModel {
  double time;
  double rate;
  String stockName;
  StoreDataModel(
      {required this.time, 
      required this.rate,
       required this.stockName});
}
