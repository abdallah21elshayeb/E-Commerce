import 'package:flutter/material.dart';
import 'package:my_souq/app/services/admin_service.dart';
import 'package:my_souq/app/widgets/analytics_charts.dart';
import 'package:my_souq/app/widgets/loader.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AdminService adminService = AdminService();

  List<Sales>? sales;
  double? totalSales;
  double? totalOrders;
  double? totalProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnalytics();
  }

  void getAnalytics() async {
    var dataSale = await adminService.getTotalSales(context);
    totalSales = dataSale['totalSales'];
    totalOrders = dataSale['totalOrders'];
    totalProducts = dataSale['totalProducts'];
    sales = dataSale['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                'Total Sales: \$$totalSales',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Total Orders: \$$totalOrders',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Total Products: \$$totalProducts',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                child: AnalyticsCharts(seriesList: [
                  LineSeries<Sales, String>(
                    dataSource: sales!,
                    xValueMapper: (Sales sales, _) => sales.label,
                    yValueMapper: (Sales sales, _) => sales.totalSale,
                    name: "Sales",
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SfSparkAreaChart.custom(
                    trackball: const SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: const SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    xValueMapper: (int index) => sales![index].label,
                    yValueMapper: (int index) => sales![index].totalSale,
                    dataCount: 5,
                  ),
                ),
              ),
            ],
          );
  }
}
