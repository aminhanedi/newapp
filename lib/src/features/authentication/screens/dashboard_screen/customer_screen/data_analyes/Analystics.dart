import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.ref().child("customer");

  Future<List<dynamic>> getMonthlyOrders() async {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    DatabaseEvent event = await _dbRef
        .orderByChild("orderDate")
        .startAt(firstDayOfMonth.millisecondsSinceEpoch.toDouble())
        .endAt(lastDayOfMonth.millisecondsSinceEpoch.toDouble())
        .once();

    DataSnapshot dataSnapshot = event.snapshot;

    List<dynamic> orders = [];

    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> data =
      dataSnapshot.value as Map<dynamic, dynamic>;

      // Filter customers based on a condition
      List<dynamic> filteredCustomers = data.values.where((customer) {
        // Replace the condition below with your own filtering logic
        DateTime orderDate = DateTime.fromMillisecondsSinceEpoch(customer['orderDate']);
        return orderDate.isAfter(firstDayOfMonth) && orderDate.isBefore(lastDayOfMonth);
      }).toList();

      // Retrieve the orders for the filtered customers
      orders = filteredCustomers;
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Orders Report'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getMonthlyOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No orders found.'),
            );
          } else {
            List<dynamic> orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Order ID: ${orders[index]['customerID']}'),
                  subtitle: Text('Order Date: ${orders[index]['customerOrder']}'),
                  // Add more details as needed
                );
              },
            );
          }
        },
      ),
    );
  }}