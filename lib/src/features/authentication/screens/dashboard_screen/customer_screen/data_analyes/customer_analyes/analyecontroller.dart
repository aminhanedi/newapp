import 'package:firebase_database/firebase_database.dart';

class OrderData {
  int day;
  int orderCount;

  OrderData(this.day, this.orderCount);
}

class MonthlyOrder {
  List<OrderData> dailyOrders = [];

  int get totalOrders {
    int total = 0;
    for (var orderData in dailyOrders) {
      total += orderData.orderCount;
    }
    return total;
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child("customer");
      DataSnapshot snapshot = await dbRef.get();

      if (snapshot.value != null) {
        Map<dynamic, dynamic> myMap = snapshot.value as Map<dynamic, dynamic>;
        Map<int, int> orderCountByDay = {};

        myMap.forEach((key, value) {
          int day = DateTime.parse(value["orderDate"]).day;
          orderCountByDay[day] = (orderCountByDay[day] ?? 0) + 1;
        });

        orderCountByDay.forEach((day, orderCount) {
          dailyOrders.add(OrderData(day, orderCount));
        });
      }
    } catch (error) {
      print("Error retrieving data: $error");
    }
  }

  Map<int, double> calculateOrderPercentage() {
    Map<int, double> orderPercentage = {};
    int total = totalOrders;
    for (var orderData in dailyOrders) {
      double percentage = (orderData.orderCount / total) * 100;
      orderPercentage[orderData.day] = percentage;
    }
    return orderPercentage;
  }

  Map<int, int> calculateOrdersPerMonth() {
    Map<int, int> ordersPerMonth = {};
    for (var orderData in dailyOrders) {
      int month = DateTime.now().month;
      ordersPerMonth[month] =
          (ordersPerMonth[month] ?? 0) + orderData.orderCount;
    }
    return ordersPerMonth;
  }

  Map<int, int> calculateOrdersPerWeek() {
    Map<int, int> ordersPerWeek = {};
    for (var orderData in dailyOrders) {
      int week = DateTime.now()
          .difference(DateTime.now().subtract(Duration(days: orderData.day)))
          .inDays ~/
          7;
      ordersPerWeek[week] = (ordersPerWeek[week] ?? 0) + orderData.orderCount;
    }
    return ordersPerWeek;
  }

  Map<int, int> calculateOrdersPerDay() {
    Map<int, int> ordersPerDay = {};
    for (var orderData in dailyOrders) {
      ordersPerDay[orderData.day] =
          (ordersPerDay[orderData.day] ?? 0) + orderData.orderCount;
    }
    return ordersPerDay;
  }
}