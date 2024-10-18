// ignore: file_names
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fyp_v101/app/modules/home/controllers/home_controller.dart';
import 'package:fyp_v101/app/ui/component/app_colors.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class linechartHomePage1 extends StatefulWidget {
  const linechartHomePage1({super.key});

  @override
  State<linechartHomePage1> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<linechartHomePage1> {
  List<Color> gradientColors = [
    const Color.fromARGB(148, 233, 181, 10),
    AppColors.contentColorRed,
  ];

  bool showAvg = false;

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2.1,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 5,
              bottom: 10,
            ),
            child: Stack(
              children: [
                // Container for rounded edges
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color.fromARGB(181, 0, 0, 0)),
                    ),
                  ),
                ),
                // LineChart
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LineChart(
                    showAvg ? avgData() : mainData(),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Legend
        Positioned(
          top: 30,
          right: 30,
          child: _buildLegend(),
        ),

        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              '',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _buildLegendItem(Colors.orangeAccent, 'kW'),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: 'lato',
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('04H', style: style);
        break;

      case 3:
        text = const Text('08H', style: style);
        break;
      case 5:
        text = const Text('12H', style: style);
        break;

      case 7:
        text = const Text('16H', style: style);
        break;
      case 9:
        text = const Text('20H', style: style);
        break;
      case 11:
        text = const Text('24H', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w400,
      fontSize: 11,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '0.5kW';
        break;
      case 2:
        text = '1.0kW';

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
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
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: homeController.past24Hrsvalues
              .reduce((value, element) => value > element ? value : element) +
          (homeController.past24Hrsvalues.reduce(
                  (value, element) => value > element ? value : element) /
              (2.5)),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, homeController.past24Hrsvalues[0]),
            FlSpot(1, homeController.past24Hrsvalues[1]),
            FlSpot(2, homeController.past24Hrsvalues[2]),
            FlSpot(3, homeController.past24Hrsvalues[3]),
            FlSpot(4, homeController.past24Hrsvalues[4]),
            FlSpot(5, homeController.past24Hrsvalues[5]),
            FlSpot(6, homeController.past24Hrsvalues[6]),
            FlSpot(7, homeController.past24Hrsvalues[7]),
            FlSpot(8, homeController.past24Hrsvalues[8]),
            FlSpot(9, homeController.past24Hrsvalues[9]),
            FlSpot(10, homeController.past24Hrsvalues[10]),
            FlSpot(11, homeController.past24Hrsvalues[11]),
            FlSpot(12, homeController.past24Hrsvalues[12]),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
