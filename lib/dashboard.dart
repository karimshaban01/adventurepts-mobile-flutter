import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final List<Map<String, dynamic>> _statistics = [
    {'title': 'Total Parcels', 'value': '156', 'icon': Icons.inventory_2},
    {'title': 'In Transit', 'value': '43', 'icon': Icons.local_shipping},
    {'title': 'Delivered', 'value': '98', 'icon': Icons.done_all},
    {'title': 'Pending', 'value': '15', 'icon': Icons.pending_actions},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: _statistics.map((stat) => _buildStatCard(stat)).toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Delivery Performance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 4),
                        const FlSpot(2, 3.5),
                        const FlSpot(3, 5),
                        const FlSpot(4, 4),
                        const FlSpot(5, 6),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Deliveries',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecentDeliveries(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              stat['icon'] as IconData,
              size: 32,
              color: Colors.blue,
            ),
            const SizedBox(height: 8),
            Text(
              stat['value'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stat['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentDeliveries() {
    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.local_shipping),
            ),
            title: Text('Parcel #${1000 + index}'),
            subtitle: Text('Delivered to: Customer ${index + 1}'),
            trailing: const Chip(
              label: Text('Delivered'),
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}