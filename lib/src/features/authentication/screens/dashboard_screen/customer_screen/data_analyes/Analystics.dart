import 'package:flutter/material.dart';

import 'customer_analyes/analyecontroller.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  MonthlyOrder monthlyOrder = MonthlyOrder();
  bool isLoading = true;



  Future<void> fetchData() async {
    await monthlyOrder.fetchDataFromFirebase();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Orders'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Orders: ${monthlyOrder.totalOrders}'),
            ElevatedButton(
              onPressed: () {
                Map<int, double> orderPercentage =
                monthlyOrder.calculateOrderPercentage();
                print('Order Percentage: $orderPercentage');
              },
              child: const Text('Calculate Order Percentage'),
            ),
            ElevatedButton(
              onPressed: () {
                Map<int, int> ordersPerMonth =
                monthlyOrder.calculateOrdersPerMonth();
                print('Orders per Month: $ordersPerMonth');
              },
              child: const Text('Calculate Orders per Month'),
            ),
            ElevatedButton(
              onPressed: () {
                Map<int, int> ordersPerWeek =
                monthlyOrder.calculateOrdersPerWeek();
                print('Orders per Week: $ordersPerWeek');
              },
              child: const Text('Calculate Orders per Week'),
            ),
            ElevatedButton(
              onPressed: () {
                Map<int, int> ordersPerDay =
                monthlyOrder.calculateOrdersPerDay();
                print('Orders per Day: $ordersPerDay');
              },
              child: const Text('Calculate Orders per Day'),
            ),
          ],
        ),
      ),
    );
  }
}