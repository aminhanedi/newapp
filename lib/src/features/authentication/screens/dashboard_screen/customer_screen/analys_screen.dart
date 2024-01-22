import 'package:flutter/material.dart';

import 'data_analyes/customer_analyes/analyecontroller.dart';

class MonthlyOrderWidget extends StatefulWidget {
  @override
  _MonthlyOrderWidgetState createState() => _MonthlyOrderWidgetState();
}

class _MonthlyOrderWidgetState extends State<MonthlyOrderWidget> {
  MonthlyOrder monthlyOrder = MonthlyOrder();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await monthlyOrder.fetchDataFromFirebase();
      setState(() {});
    } catch (error) {
      print("Error retrieving data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate statistics
    Map<int, double> orderPercentage = monthlyOrder.calculateOrderPercentage();
    Map<int, int> ordersPerMonth = monthlyOrder.calculateOrdersPerMonth();
    Map<int, int> ordersPerWeek = monthlyOrder.calculateOrdersPerWeek();
    Map<int, int> ordersPerDay = monthlyOrder.calculateOrdersPerDay();

    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly Orders"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Percentage:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var entry in orderPercentage.entries)
              Text("Day ${entry.key}: ${entry.value.toStringAsFixed(2)}%"),

            SizedBox(height: 20),

            Text(
              "Orders per Month:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var entry in ordersPerMonth.entries)
              Text("Month ${entry.key}: ${entry.value}"),

            SizedBox(height: 20),

            Text(
              "Orders per Week:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var entry in ordersPerWeek.entries)
              Text("Week ${entry.key}: ${entry.value}"),

            SizedBox(height: 20),

            Text(
              "Orders per Day:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var entry in ordersPerDay.entries)
              Text("Day ${entry.key}: ${entry.value}"),
          ],
        ),
      ),
    );
  }
}