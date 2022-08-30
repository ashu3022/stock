import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stock/home/model/controller/home_controller.dart';
import 'package:stock/home/model/stock_data_model.dart';
import 'package:stock/utils/variable_utilities.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  HomeScreenController controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    VariableUtilities.size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: GetBuilder<HomeScreenController>(
              init: controller, 
              builder: (_) {
                return Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Stocks",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: VariableUtilities.size.width * 0.04)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                                        //for graph
                          },
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(5),
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            child: Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.onPauseResume(val: controller.isResume);
                            controller.updateData(
                                isUpdate: controller.isResume);
                          },
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(5),
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            child: Icon(
                              controller.isResume
                                  ? Icons.play_arrow
                                  : Icons.pause,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(top: 15),
                              itemCount: controller.stockData?.data.length ?? 0,
                              itemBuilder: (context, index) {

                                return Column(
                                  children: [
                                    buildDataTile(
                                        rate: controller
                                            .stockData!.data[index].price
                                            .toString(),
                                        stockName: controller
                                            .stockData!.data[index].sid,
                                        onTap: () {
                                          
                                          //for graph
                                        },
                                        isDown: controller.stockData!
                                            .data[index].change.isNegative),
                                    Divider(
                                      color: Colors.blueGrey.withOpacity(0.5),
                                      thickness: 1,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),


                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget buildDataTile(
      {required bool isDown,
      required String stockName,
      required Function() onTap,
      required String rate}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: 40,
        width: VariableUtilities.size.width,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              stockName,
              style: TextStyle(
                color: Colors.black,
                fontSize: VariableUtilities.size.width * 0.045,
              ),
            ),
            Row(
              children: [
                Text(
                  "\u{20B9} ${rate}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: VariableUtilities.size.width * 0.045,
                  ),
                ),
                isDown == true
                    ? Transform.rotate(
                        angle: pi / 2,
                        child: Icon(Icons.play_arrow,
                            size: VariableUtilities.size.width * 0.045,
                            color: Colors.red),
                      )
                    : Transform.rotate(
                        angle: 3 * pi / 2,
                        child: Icon(Icons.play_arrow,
                            size: VariableUtilities.size.width * 0.045,
                            color: Colors.green),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
