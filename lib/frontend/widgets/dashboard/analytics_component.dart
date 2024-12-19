import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsComponent extends StatelessWidget {
  const AnalyticsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bar Chart (Placeholder)
          Text('Sales Analytics', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16),
          SizedBox(
            height: 200, // Set a fixed height for the bar chart
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(show: false),
                gridData: FlGridData(show: false),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(toY: 8, color: Colors.blue),
                  ]),
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(toY: 6, color: Colors.blue),
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(toY: 7, color: Colors.blue),
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),

          // Pie Chart (Placeholder)
          Text('Product Distribution', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16),
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(value: 40, color: Colors.blue, title: 'Category 1'),
                PieChartSectionData(value: 30, color: Colors.green, title: 'Category 2'),
                PieChartSectionData(value: 20, color: Colors.orange, title: 'Category 3'),
                PieChartSectionData(value: 10, color: Colors.red, title: 'Category 4'),
              ],
            ),
          ),
          SizedBox(height: 32),

          // Line Chart (Placeholder)
          Text('Monthly Sales Trend', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16),
          LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 3),
                    FlSpot(1, 1),
                    FlSpot(2, 4),
                    FlSpot(3, 3),
                    FlSpot(4, 5),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),

          // Percentage Chart (Placeholder)
          Text('Product Sales Percentage', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.75, // Example progress
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          SizedBox(height: 16),
          Text('75% of sales target reached'),
        ],
      ),
    );
  }
}