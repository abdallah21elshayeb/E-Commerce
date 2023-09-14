import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:my_souq/app/models/sales.dart';

class AnalyticsCharts extends StatelessWidget {
  const AnalyticsCharts({Key? key, required this.seriesList}) : super(key: key);

  final List<ChartSeries<Sales, String>> seriesList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SfCartesianChart(
              primaryXAxis: CategoryAxis(
                title: AxisTitle(text: 'Categories'),
                labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                majorTickLines: const MajorTickLines(width: 2),
              ),
              title: ChartTitle(text: 'Statistics for products sales'),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: seriesList),
        ],
      ),
    );
  }
}
