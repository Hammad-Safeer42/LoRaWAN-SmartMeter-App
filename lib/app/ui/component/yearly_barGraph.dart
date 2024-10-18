import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/ui/component/app_colors.dart';
import 'package:fyp_v101/util/color_extensions.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YearlyBarChart extends StatefulWidget {
  YearlyBarChart({super.key});
  final Color leftBarColor = const Color(0xff1814F3);
  final Color rightBarColor = const Color(0xff16DBCC);
  final Color avgColor =
      AppColors.contentColorOrange.avg(AppColors.contentColorRed);
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<YearlyBarChart> {
  var controller = Get.find<HomeController>();

  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(
        0,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Jan'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Jan'] ??
                0.0)
            .toDouble());

    final barGroup2 = makeGroupData(
        1,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Feb'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Feb'] ??
                0.0)
            .toDouble());

    final barGroup3 = makeGroupData(
        2,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Mar'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Mar'] ??
                0.0)
            .toDouble());

    final barGroup4 = makeGroupData(
        3,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Apr'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Apr'] ??
                0.0)
            .toDouble());
    final barGroup5 = makeGroupData(
        4,
        (controller.auth.userdata.value?.extra['currYearHistory']?['May'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['May'] ??
                0.0)
            .toDouble());
    final barGroup6 = makeGroupData(
        5,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Jun'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Jun'] ??
                0.0)
            .toDouble());
    final barGroup7 = makeGroupData(
        6,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Jul'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Jul'] ??
                0.0)
            .toDouble());
    final barGroup8 = makeGroupData(
        7,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Aug'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Aug'] ??
                0.0)
            .toDouble());
    final barGroup9 = makeGroupData(
        8,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Sep'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Sep'] ??
                0.0)
            .toDouble());
    final barGroup10 = makeGroupData(
        9,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Oct'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Oct'] ??
                0.0)
            .toDouble());
    final barGroup11 = makeGroupData(
        10,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Nov'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Nov'] ??
                0.0)
            .toDouble());
    final barGroup12 = makeGroupData(
        11,
        (controller.auth.userdata.value?.extra['currYearHistory']?['Dec'] ??
                0.0)
            .toDouble(),
        (controller.auth.userdata.value?.extra['PreviousYearHistory']?['Dec'] ??
                0.0)
            .toDouble());

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.58,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[],
                ),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      maxY: 850,
                      barTouchData: BarTouchData(
                        handleBuiltInTouches: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (group) {
                            return Colors
                                .grey; // Set the tooltip background color
                          },
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            // Retrieve the value of the touched bar
                            String barValue = rod.toY.toStringAsFixed(
                                2); // rod.y.toStringAsFixed(2);
                            // Return a tooltip item with the value displayed on top of the bar
                            return BarTooltipItem(
                              barValue,
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        touchCallback:
                            (FlTouchEvent event, BarTouchResponse? response) {
                          if (response != null && response.spot != null) {
                            setState(() {
                              touchedGroupIndex =
                                  response.spot!.touchedBarGroupIndex;
                            });
                          } else {
                            setState(() {
                              touchedGroupIndex = -1;
                            });
                          }
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: bottomTitles,
                            reservedSize: 30,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                      gridData: FlGridData(
                        drawVerticalLine: false,
                        show: true,
                        drawHorizontalLine:
                            true, // Set to true to draw horizontal lines
                        horizontalInterval:
                            100, // Interval between horizontal lines
                        getDrawingHorizontalLine: (value) {
                          return const FlLine(
                            color: Colors.grey, // Color of the horizontal line
                            strokeWidth: 0.7, // Width of the horizontal line
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ),

        // Legend
        Positioned(
          top: 15,
          right: 30,
          child: _buildLegend(),
        ),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 200) {
      text = '200';
    } else if (value == 400) {
      text = '400';
    } else if (value == 600) {
      text = '600';
    } else if (value == 800) {
      text = '800';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 12, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}

Widget _buildLegend() {
  return Row(
    children: [
      _buildLegendItem(const Color(0xff1814F3), 'curr. Year    '),
      _buildLegendItem(const Color(0xff16DBCC), 'Last Year'),
    ],
  );
}

Widget _buildLegendItem(Color color, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

          color: color, // Adjust the radius for circular edges
          // Set your desired background color
        ),
      ),
      const SizedBox(width: 5),
      Text(
        text,
        style: const TextStyle(
            fontFamily: 'lato',
            fontSize: 12,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
    ],
  );
}
