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
        } else {
          return _buildStatsUI(snapshot.data!);
        }
      },
    );
  }

  Widget _buildStatsUI(Stats stats) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildPieChart('Type de Ressources')),
                Expanded(child: _buildBarChart('Posts de la semaine')),
              ],
            ),
          ),
          const Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Postes par jour',
                      style: TextStyle(
                        fontSize: 18, // Change the font size
                        fontWeight: FontWeight.bold, // Make the text bold
                        color: Color(0xFF45B39D), // Change the text color
                        // Add more text styles as needed
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Posts sur 5 jours',
                      style: TextStyle(
                        fontSize: 18, // Change the font size
                        fontWeight: FontWeight.bold, // Make the text bold
                        color: Color(0xFF45B39D), // Change the text color
                        // Add more text styles as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Row(
              children: [
                Expanded(child: Center(child: Text('Postes par jour'))),
                Expanded(child: Center(child: Text('Posts sur 5 jours'))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(String title) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 40,
                  color: const Color(0xFF45B39D),
                  title: '40%',
                ),
                PieChartSectionData(
                  value: 30,
                  color: const Color(0xff73c6b6),
                  title: '30%',
                ),
                PieChartSectionData(
                  value: 20,
                  color: const Color(0xff7dcea0),
                  title: '20%',
                ),
                PieChartSectionData(
                  value: 10,
                  color: const Color(0xfff8c471),
                  title: '10%',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart(String title) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: [
                _buildBarChartGroupData(0, 5, const Color(0xFF45B39D)),
                _buildBarChartGroupData(1, 6, const Color(0xff73c6b6)),
                _buildBarChartGroupData(2, 8, const Color(0xff7dcea0)),
                _buildBarChartGroupData(3, 3, const Color(0xfff8c471)),
                _buildBarChartGroupData(4, 70, const Color(0xffdaf7a6)),
              ],
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
                      Widget text;
                      switch (value.toInt()) {
                        case 0:
                          text = const Text('Lun', style: style);
                          break;
                        case 1:
                          text = const Text('Mar', style: style);
                          break;
                        case 2:
                          text = const Text('Mer', style: style);
                          break;
                        case 3:
                          text = const Text('Jeu', style: style);
                          break;
                        case 4:
                          text = const Text('Ven', style: style);
                          break;
                        default:
                          text = const Text('', style: style);
                          break;
                      }
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 16, // margin top
                        child: text,
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
                      } else if (value == 5) {
                        text = '5';
                      } else if (value == 10) {
                        text = '10';
                      } else {
                        text = '';
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

  BarChartGroupData _buildBarChartGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 22,
          borderRadius: const BorderRadius.all(Radius.zero),
        ),
      ],
    );
  }
}
