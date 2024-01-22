import 'package:flutter/material.dart';

import 'analyecontroller.dart';

class CustomerAnalyeses extends StatefulWidget {
  const CustomerAnalyeses({required Key key}) : super(key: key);

  @override
  _CustomerAnalyesesState createState() => _CustomerAnalyesesState();
}

class _CustomerAnalyesesState extends State<CustomerAnalyeses> {
  MonthlyOrder monthlyOrder = MonthlyOrder();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    monthlyOrder.fetchDataFromFirebase().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Page'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() // Show a loading indicator while fetching data
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Orders: ${monthlyOrder.totalOrders}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Order Percentage:',
              style: const TextStyle(fontSize: 20),
            ),
            ...monthlyOrder.calculateOrderPercentage().entries.map(
                  (entry) => Text(
                'Day ${entry.key}: ${entry.value.toStringAsFixed(2)}%',
                style: const TextStyle(fontSize: 16),
              ),
            ).toList(),
          ],
        ),
      ),
    );
  }
}