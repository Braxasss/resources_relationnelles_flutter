import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:resources_relationnelles_flutter/classes/stats.dart';

class StatsWidget extends StatelessWidget {
  final Future<Stats> statsFuture;

  const StatsWidget({super.key, required this.statsFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stats>(
      future: statsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return _buildStatsUI(snapshot.data!);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildStatsUI(Stats stats) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Flexible(child: _buildPieChart('Type de Ressources', stats)),
                Flexible(child: _buildBarChart('Posts soumis les 5 derniers jours', stats)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      'Postes par jour',
                      style: _textStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFF45B39D),
    );
  }

  Widget _buildPieChart(String title, Stats stats) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 200, // Set a fixed height for the chart
          child: PieChart(
            PieChartData(
              sections: stats.ressourceByCategories.map((category) {
                return PieChartSectionData(
                  value: category.ressourceCount.toDouble(),
                  color: Colors.primaries[category.categoryName.hashCode % Colors.primaries.length],
                  title: '${category.ressourceCount}',
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart(String title, Stats stats) {
    List<String> days = stats.ressourceByDays.keys.toList();
    List<int> values = stats.ressourceByDays.values.toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 200, // Set a fixed height for the chart
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(days.length, (index) {
                return _buildBarChartGroupData(index, values[index].toDouble());
              }),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const style = TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 16, // margin top
                        child: Text(days[value.toInt()].split('-').last, style: style),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const style = TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      String text;
                      if (value == 0) {
                        text = '0';
                      } else {
                        text = value.toInt().toString();
                      }
                      return Text(text, style: style);
                    },
                    reservedSize: 28,
                    interval: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData _buildBarChartGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.primaries[x % Colors.primaries.length],
          width: 22,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
      ],
    );
  }
}
