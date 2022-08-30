import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock/graph_screen/controller/graph_controller.dart';
import 'package:stock/utils/variable_utilities.dart';

class GraphScreen extends StatelessWidget {
  GraphScreen({Key? key}) : super(key: key);
  GraphScreenController controller = Get.put(GraphScreenController());
  @override
  Widget build(BuildContext context) {
    VariableUtilities.size = MediaQuery.of(context).size;
    controller.filterData(name: Get.arguments);
    //yaha daala
    var i;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<GraphScreenController>(
            init: controller,
            builder: (_) {
              double change = 0;
              double secondLast = 0;
              int green;
              double last =
                  controller.priceList[controller.priceList.length - 1];
              if (controller.priceList.length < 1)
                change = last;
              else {
                change =
                    (controller.priceList[controller.priceList.length - 2] -
                            last)
                        .toPrecision(2);
                secondLast =
                    controller.priceList[controller.priceList.length - 2];
              }
              if (change > 0)
                green = 1;
              else if (change == 0)
                green = 0;
              else
                green = -1;
                // yaha kia
              if (controller.priceList.length == 0)
                return Scaffold(
                  body: Text(
                    "No data recorded",
                    style: TextStyle(fontSize: 12),
                  ),
                );

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        Text("${Get.arguments}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: VariableUtilities.size.width * 0.05,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.priceList[controller.priceList.length - 1]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 25),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            if (green == 1)
                              Icon(
                                Icons.arrow_drop_up_sharp,
                                color: Colors.green,
                                size: 30,
                              )
                            else if (green == -1)
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.red,
                                size: 30,
                              )
                            else
                              Icon(
                                Icons.square_outlined,
                                color: Color.fromARGB(255, 112, 111, 111),
                                size: 15,
                              ),
                            //Icon(Icons.arrow_upward_sharp ,color:Colors.green)?green==1:Icon(Icons.arrow_downward_sharp,color:Colors.red),
                            Text("${change.abs()}"),
                            if (secondLast != 0 && change > 0)
                              Text("(+" +
                                  "${((change.abs() / secondLast) * 100).toStringAsPrecision(2)}" +
                                  "%)")
                            else if (secondLast != 0 && change < 0)
                              Text("(-" +
                                  "${((change.abs() * 100 / secondLast)).toPrecision(2)}" +
                                  "%)")
                            else
                              Text("(+0%)")
                          ],
                        )),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        //width: VariableUtilities.size.width,
                        width: 5000,
                        margin: EdgeInsets.only(right: 10, top: 10, bottom: 0),
                        height: 580,
                        child: LineChart(
                          LineChartData(
                            backgroundColor: Color.fromARGB(255, 239, 239, 237),
                            titlesData: FlTitlesData(
                              // bottomTitles: SideTitles(showTitles: false),
                              // leftTitles: SideTitles(showTitles: false),
                              // rightTitles: SideTitles(showTitles: false),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                showTitles: true,
                               //interval: 10,
                                //getTitlesWidget: leftTitleWidgets,
                                reservedSize: 45,
                              )),
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                showTitles: true,
                                interval: 5,
                                //getTitlesWidget: leftTitleWidgets,
                                reservedSize: 100,
                              )),
                              //  topTitles: SideTitles(showTitles: false),
                            ),
                            // maxX: 500,
                            maxX: 1000,
                            minX: 0,
                            minY: 0.99 * controller.priceList[0],
                            maxY: 1.01 * controller.priceList[0],
                            // minY: 0.90*
                            //     (controller.priceList.reduce(
                            //         (curr, next) => curr > next ? curr : next)),
                            // maxY: 1.1 *
                            //     (controller.priceList.reduce(
                            //         (curr, next) => curr > next ? curr : next)),

                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: Colors.black, width: 1),
                            ),

                            // gridData: FlGridData(
                            //   show: false,
                            //   getDrawingHorizontalLine: (value) {
                            //     return FlLine(
                            //       color: Colors.red,
                            //       strokeWidth: 5,
                            //     );
                            //   },
                            // ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: controller.filteredData.map((e) {
                                  debugPrint("POINT WITH ${e.date}");
                                  //            ye pehle wala h                 return FlSpot(e.date.second.toDouble() , e.rate);
                                  return FlSpot(
                                      controller.filteredData.indexOf(e).toDouble()*5,
                                      e.rate);
                                  // e.date.second.toDouble(), e.rate);
                                  //double.parse (e.date.minute.toString()+"."+e.date.second.toString()), e.rate);
                                  //e.date.minute.toDouble()+e.date.second.toDouble()/100, e.rate);
                                }).toList(),
                                isCurved: true,
                                color: Colors.green,
                                barWidth: 2,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.green.shade200,
                                        Colors.green.shade200,
                                        Colors.green.shade200,
                                        Colors.green.shade100,
                                        Colors.green.shade50,
                                        Colors.white,
                                        Colors.white,
                                      ]),
                                ),
                                isStrokeJoinRound: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
