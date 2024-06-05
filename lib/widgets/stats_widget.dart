import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildPieChart('Type de Ressources')),
                Expanded(child: _buildPieChart('')),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildPieChart('Chart 3')),
                Expanded(child: _buildPieChart('Chart 4')),
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
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
}
