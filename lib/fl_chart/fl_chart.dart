import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartIngresosGastos extends StatelessWidget {
  const BarChartIngresosGastos({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 10000,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', "Sep", "Oct", "Nov", "Dic"];
                  return Text(months[value.toInt()],
                      style: const TextStyle(color: Colors.black));
                },
                reservedSize: 32,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: true),
          barGroups: [
            // Enero
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Febrero
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Marzo
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Abril
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Mayo
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Junio
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Julio
            BarChartGroupData(x: 6, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Agosto
            BarChartGroupData(x: 7, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Septiembre
            BarChartGroupData(x: 8, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Octubre
            BarChartGroupData(x: 9, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Noviembre
            BarChartGroupData(x: 10, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
            // Diciembre
            BarChartGroupData(x: 11, barRods: [
              BarChartRodData(toY: 0, color: Colors.blue[300], width: 14),
              BarChartRodData(toY: 0, color: Colors.red[300], width: 14),
            ]),
          ],
        ),
      ),
    );
  }
}
